package jp.taira.sample.utils;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class StringUtils {
    /**
     * nullか空文字かを判断する。
     *
     * @param target 対象文字列
     * @return nullか空文字である場合はtrue、そうでない場合はfalse。
     */
    public static boolean isEmpty(final String target) {
        return target == null || target.length() == 0;
    }
}
