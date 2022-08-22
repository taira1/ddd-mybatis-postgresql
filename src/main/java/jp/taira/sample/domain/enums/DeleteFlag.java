package jp.taira.sample.domain.enums;

import jp.taira.sample.utils.EnumUtils;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public enum DeleteFlag implements EnumStringKeyAccessor {
    NOT_DELETED("0"),
    DELETED("1");

    private final String key;

    public static DeleteFlag of(String key) {
        final var type = EnumUtils.of(key, DeleteFlag.class);

        return type.orElseThrow();
    }
}
