package ua.com.nc.dao.implementation;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import ua.com.nc.dao.PersistException;
import ua.com.nc.dao.interfaces.AttendanceStatusDao;
import ua.com.nc.domain.AttendanceStatus;

import javax.sql.DataSource;
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

    @Autowired
    public AttendanceStatusDaoImpl(DataSource dataSource) throws PersistException {
        super(dataSource);
    }

    @Override
    protected String getSelectQuery() {
        return attendanceStatusSelectAll;
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