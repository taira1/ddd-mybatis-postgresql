package jp.taira.sample.infrastructure.handler;

import jp.taira.sample.domain.enums.DeleteFlag;
import jp.taira.sample.utils.EnumUtils;
import jp.taira.sample.utils.StringUtils;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DeleteFlagHandler extends BaseTypeHandler<DeleteFlag> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, DeleteFlag parameter, JdbcType jdbcType) throws SQLException {
        ps.setString(i, EnumUtils.getKey(parameter).orElse(null));
    }

    @Override
    public DeleteFlag getNullableResult(ResultSet rs, String columnName) throws SQLException {
        var value = rs.getString(columnName);
        if (StringUtils.isEmpty(value)) {
            return null;
        }

        return DeleteFlag.of(value);
    }

    @Override
    public DeleteFlag getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        var value = rs.getString(columnIndex);
        if (StringUtils.isEmpty(value)) {
            return null;
        }

        return DeleteFlag.of(value);
    }

    @Override
    public DeleteFlag getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        var value = cs.getString(columnIndex);
        if (StringUtils.isEmpty(value)) {
            return null;
        }

        return DeleteFlag.of(value);
    }
}