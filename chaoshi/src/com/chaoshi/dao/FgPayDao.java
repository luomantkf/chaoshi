package com.chaoshi.dao;

import com.chaoshi.model.FgOrder;
import com.chaoshi.model.FgOrderVo;
import com.chaoshi.model.FgPay;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/1/21.
 */
public class FgPayDao {
    public Integer insertFgOrder(Connection con, FgPay pay) {
        String sql = "insert into  fg_pay(payId,orderIds,payTime,payType) values(?,?,?,?)";
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, pay.getPayId());
            pstmt.setString(2, pay.getOrderIds());
            pstmt.setString(3, pay.getPayTime());
            pstmt.setShort(4,pay.getPayType());
            if (pstmt.executeUpdate() == 1) {
                ResultSet rs=pstmt.getGeneratedKeys();
                if(rs.next()){
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }
    public List<FgOrderVo> listFgOrderVo(Connection con,Integer userId){
        String sql="select fg_order.id as id,goodName,price,count,(price*count) as money,DATE_FORMAT(createTime,'%Y-%m-%d %H:%i:%S') as createTime from bg_good,fg_order where fg_order.good_id=bg_good.id and status=0 and user_id=? and count <> 0  order by creatTime DESC";
        List lists=new ArrayList<FgOrderVo>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,userId);
            rs=pstmt.executeQuery();
            while(rs.next()){
                FgOrderVo fgOrderVo=new FgOrderVo();
                fgOrderVo.setId(rs.getInt("id"));
                fgOrderVo.setGoodName(rs.getString("goodName"));
                fgOrderVo.setPrice(rs.getDouble("price"));
                fgOrderVo.setCount(rs.getInt("count"));
                fgOrderVo.setMoney(rs.getDouble("money"));
                fgOrderVo.setCreateTime(rs.getString("createTime"));
                lists.add(fgOrderVo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }

}
