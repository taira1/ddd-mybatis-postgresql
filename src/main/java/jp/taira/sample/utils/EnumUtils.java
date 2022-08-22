package jp.taira.sample.utils;

import jp.taira.sample.domain.enums.EnumByteKeyAccessor;
import jp.taira.sample.domain.enums.EnumIntegerKeyAccessor;
import jp.taira.sample.domain.enums.EnumStringKeyAccessor;
import jp.taira.sample.domain.enums.EnumStringValueAccessor;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;

import javax.annotation.Nullable;
import java.util.Optional;
import java.util.stream.Stream;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class EnumUtils {

    public static <T extends Enum<T> & EnumStringKeyAccessor> Optional<T> of(String key, Class<T> enumClass) {
        return Stream.of(enumClass.getEnumConstants())
                .filter(enums -> StringUtils.isNotEmpty(enums.getKey()) && enums.getKey().equals(key))
                .findFirst();
    }

    public static <T extends Enum<T> & EnumStringValueAccessor> Optional<T> fromValue(String value, Class<T> enumClass) {
        return Stream.of(enumClass.getEnumConstants())
                .filter(enums -> enums.getValue().equals(value))
                .findFirst();
    }

    public static <T extends Enum<T> & EnumByteKeyAccessor> Optional<T> of(byte key, Class<T> enumClass) {
        return Stream.of(enumClass.getEnumConstants())
                .filter(enums -> enums.getKey() == key)
                .findFirst();
    }

    public static <T extends Enum<T> & EnumIntegerKeyAccessor> Optional<T> of(Integer key, Class<T> enumClass) {
        return Stream.of(enumClass.getEnumConstants())
                .filter(enums -> enums.getKey().equals(key))
                .findFirst();
    }

    /**
     * Enumのキー値を取得する。
     * Enumがnullの場合は空のOptionalを返却する。
     *
     * @param <T> EnumStringKeyAccessorを実装したEnumクラス
     * @param enums nullableなenumクラス
     * @return key値を取得する
     */
    public static <T extends Enum<T> & EnumStringKeyAccessor> Optional<String> getKey(@Nullable T enums) {
        if (enums == null) {
            return Optional.empty();
        }

        return Optional.of(enums.getKey());
    }

    /**
     * Enumのキー値を取得する。
     * Enumがnullの場合は空のOptionalを返却する。
     *
     * @param enums nullableなenumクラス
     * @param <T> EnumStringKeyAccessorを実装したEnumクラス
     * @return key値を取得する
     */
    public static <T extends Enum<T> & EnumIntegerKeyAccessor> Optional<Integer> getIntegerKey(@Nullable T enums) {
        if (enums == null) {
            return Optional.empty();
        }

        return Optional.of(enums.getKey());
    }

    /**
     * Enumの値を取得する。
     * Enumがnullの場合は空のOptionalを返却する。
     *
     * @param <T> EnumStringKeyAccessorを実装したEnumクラス
     * @param enums nullableなenumクラス
     * @return 値を取得する
     */
    public static <T extends Enum<T> & EnumStringValueAccessor> Optional<String> getValue(@Nullable T enums) {
        if (enums == null) {
            return Optional.empty();
        }

        return Optional.of(enums.getValue());
    }

    /**
     * Enumの値を取得する。
     * Enumがnullの場合は空のOptionalを返却する。
     *
     * @param <T> EnumByteKeyAccessorを実装したEnumクラス
     * @param enums nullableなenumクラス
     * @return 値を取得する
     */
    public static <T extends Enum<T> & EnumByteKeyAccessor> Optional<Byte> getByteKey(@Nullable T enums) {
        if (enums == null) {
            return Optional.empty();
        }

        return Optional.of(enums.getKey());
    }
}
