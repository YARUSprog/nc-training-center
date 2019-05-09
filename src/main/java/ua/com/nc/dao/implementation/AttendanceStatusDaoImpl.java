package ua.com.nc.dao.implementation;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import ua.com.nc.dao.PersistException;
import ua.com.nc.dao.interfaces.AttendanceStatusDao;
import ua.com.nc.domain.AttendanceStatus;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
@Log4j
@Component
@PropertySource("classpath:sql_queries.properties")
public class AttendanceStatusDaoImpl extends AbstractDaoImpl<AttendanceStatus> implements AttendanceStatusDao {

    @Value("${attendance_status.select-all}")
    private String attendanceStatusSelectAll;

    public AttendanceStatusDaoImpl(@Value("${spring.datasource.url}") String DATABASE_URL,
                                   @Value("${spring.datasource.username}") String DATABASE_USER,
                                   @Value("${spring.datasource.password}") String DATABASE_PASSWORD) throws PersistException {
        super(DATABASE_URL, DATABASE_USER, DATABASE_PASSWORD);
    }


    @Override
    protected Integer parseId(ResultSet rs) {
        return null;
    }

    @Override
    protected String getSelectByIdQuery() {
        return null;
    }

    @Override
    protected String getSelectQuery() {
        return attendanceStatusSelectAll;
    }

    @Override
    protected String getInsertQuery() {
        return null;
    }

    @Override
    protected String getDeleteQuery() {
        return null;
    }

    @Override
    protected String getUpdateQuery() {
        return null;
    }

    @Override
    protected void prepareStatementForInsert(PreparedStatement statement, AttendanceStatus entity) {

    }

    @Override
    protected void prepareStatementForUpdate(PreparedStatement statement, AttendanceStatus entity) {

    }

    @Override
    protected List<AttendanceStatus> parseResultSet(ResultSet rs) throws SQLException {
        List<AttendanceStatus> list = new ArrayList<>();
        while (rs.next()) {
            Integer id = rs.getInt("ID");
            String title = rs.getString("TITLE");
            AttendanceStatus reason = new AttendanceStatus(id, title);
            list.add(reason);
        }
        return list;
    }

    @Override
    public List<AttendanceStatus> getAll() {
        String sql = attendanceStatusSelectAll;
        log.info(sql + "select all attendance status");
        return getListFromSql(sql);
    }
}
