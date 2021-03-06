package com.nokia.tudms.dao.admin;

import com.alibaba.druid.pool.DruidPooledConnection;
import com.nokia.tudms.dao.DBPool;

import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * @Author Rin
 * @Date 2017/5/5
 */
public class DeleteToolDAO {
    public static boolean deleteTool(int toolId){
        boolean status = false;
        try {
            DruidPooledConnection connection = DBPool.getInstance().getConnection();
            PreparedStatement ps = connection.prepareStatement("DELETE FROM `tool` WHERE `tool-id`=?");
            ps.setInt(1, toolId);
            ps.execute();
            ps.close();
            connection.close();
            status=true;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return status;
    }
}
