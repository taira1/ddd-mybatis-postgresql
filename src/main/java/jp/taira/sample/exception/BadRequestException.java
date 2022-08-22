package jp.taira.sample.exception;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

import java.util.List;

@Getter
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class BadRequestException extends ApiException {

    private static final HttpStatus STATUS = HttpStatus.BAD_REQUEST;

    public BadRequestException(String message) {
        super(message, STATUS);
    }

    public BadRequestException(List<String> message) {
        super(message, STATUS);
    }

    public BadRequestException(String message, Throwable e) {
        super(message, e, STATUS);
    }
}
