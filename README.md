# ddd-mybatis-postgresql

## 開発環境構築

### IntelliJまたはeclipseインストール

### コンテナの起動

~~~console
docker-compose up
~~~

### コンテナの停止

~~~console
docker-compose down
~~~

※docker/db/initフォルダ内のsqlに変更が入った場合は、docker-compose down, docker-compose up を行ってください。

### コンテナにログイン

`docker exec -it {コンテナ名} bash`コマンドを実行する

~~~console
# app
docker exec -it sample_app bash

# db
docker exec -it sample_db bash
~~~

### ビルド

~~~console
docker exec -it sample_app bash
.\gradlew classes
~~~

また、build.gradleの
`def skipOpenApi = ture`
にすることでOpenApi generateをskip可能。
generateの処理は時間がかかるため、YAML作成時以外は、skip（上記プロパティをtrue）にすること。

---

## 移行データの投入方法

1. dbコンテナにログイン
    ~~~console
    docker exec -it sample_db bash
    ~~~

2. sqlsディレクトリに移動
    ~~~console
    cd sqls
    ~~~

3. 移行データを挿入するシェルを実行
    ~~~console
    sh insert_migration_data.sh
    ~~~

---

## swagger自動生成

本プロジェクトではcontroller/request/responseの定義をswaggerから自動生成する。

#### 作業手順

1. Swaggerファイルをsrc/main/resources/swaggerに配置
2. `./gradlew build -x test` 実行
3. `jp.taira.sample.swagger.generated` 配下にファイル名に応じたパッケージが作成されていることを確認（改行コードはLFにしてください）

### 利用方法

`presentation/controller/{機能カテゴリ}`配下にパッケージ名に応じたControllerクラスを作成する。  
自動生成されたインターフェースをimplements、Overrideし実装すること。

-- 例 --

~~~java
package jp.taira.sample.presentation.controller.spa;

// 略
public class SAMPLEController extends BaseController implements SsampleApi {

    private final SAMPLEService sampleService;

    /**
     * {@inheritDoc}
     */
    @Override
    @RequestMapping(
            method = RequestMethod.GET,
            value = "/sample-information",
            produces = {"application/json"}
    )
    public ResponseEntity<SampleInformationResponse> sMPLEG(
            @NotNull @ApiParam(value = "画面.サンプル番号", required = true)
            @Valid @RequestParam(value = "sampleNumber") String sampleNumber) {
        // 略
    }
}
~~~

## レイヤ化

ドメイン駆動設計に基づき処理を各レイヤーに分割させる。

#### レイヤ概要

- presentation層  
  ユーザのリクエストを受け付け、レスポンスを返却する層。
    - controller  
      リクエスト/レスポンスのハンドリング、バリデーション実行。
    - request  
      swagger自動生成オブジェクトを使用するので基本的に不使用。
    - response  
      dto -> 自動生成responseのconvertを実行
- application層  
  ビジネスロジックのワークフロー制御、トランザクション・セキュリティ制御などを実行する。
    - service  
      ワークフロー、トランザクション管理。簡易なロジックであればこちらで実装。
    - dto  
      DataTransferObject。domain/objectとrequest/responseの橋渡し。
- domain層  
  ビジネスロジック実行箇所。  
  modelクラスはserviceが肥大化する場合や共通化が必要な場合のみ実装。
    - enums  
      key:valueのマッピングオブジェクト
    - object  
      ドメインオブジェクト。  
      依存関係のあるobject/valueをマッピングするために使用。
      他objectに干渉しない、データ永続化に関与しないビジネスロジックはこちらまたはobject/valueに実装。↓例
      ~~~java
      package jp.taira.sample.domain.object.test.value;
  
      public class Account {
        /**
         * 支払方式が現金の場合銀行情報をクリアする
         */
        public void clearBankInfoIfPaymentMethodIsCash() {
            if (paymentMethod == PaymentMethod.CASH) {
                this.bankCode = null;
                this.bankBranchCode = null;
                this.bankAccountType = null;
                this.bankAccountNumber = null;
                this.bankAccountName = null;
            }
        }
      }
      ~~~
    - object/value  
      DBテーブルと対応するバリューオブジェクト。
    - model  
      データ永続化に関わらず、複数のobjectにまたがるロジックを実行するクラス。    
      serviceのロジックが肥大化する場合に実装。
    - repository  
      DBデータアクセスインターフェース。
- infrastructure層  
  外部データアクセス層。
    - dao  
      DBアクセス実行クラス。  
      単一テーブルのレコードを返却する場合はsimpleに、  
      複数テーブルのレコードを返却する場合はcomplicationに実装。
    - repository  
      CRUD処理呼び出しクラス。  
      Daoを呼び出しdomain/objectを返却する。
    - handler  
      dbの値とenum値のマッピングハンドラー。  
      こちらを定義することでmybatisでenumの取得/返却ができるようになる。
- swagger層  
  自動生成されたオブジェクトが配置される層。

