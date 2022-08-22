package jp.taira.sample.exception;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

import java.util.Collections;
import java.util.List;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
public abstract class ApiException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    private HttpStatus httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;

    private List<String> errors;

    public ApiException(final String message) {
        super(message);
        this.errors = Collections.singletonList(message);
    }

    public ApiException(final List<String> message, HttpStatus status) {
        super(message.toString());
        this.errors = message;
        this.httpStatus = status;
    }

    public ApiException(final String message, final HttpStatus status) {
        super(message);
        this.errors = Collections.singletonList(message);
        this.httpStatus = status;
    }

    public ApiException(final String message, final Throwable e, final HttpStatus status) {
        super(e);
        this.errors = Collections.singletonList(message);
        this.httpStatus = status;
    }
}
