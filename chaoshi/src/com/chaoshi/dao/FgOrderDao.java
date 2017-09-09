package com.chaoshi.dao;

import com.chaoshi.model.FgOrder;
import com.chaoshi.model.FgOrderVo;
import com.chaoshi.util.DateUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/1/21.
 */
public class FgOrderDao {
    public  boolean insertFgOrder(Connection con,FgOrder order){
        String sql="insert into  fg_order(user_id,good_id,money) values(?,?,?)";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setInt(1, order.getUserId());
            pstmt.setInt(2, order.getGoodId());
            pstmt.setDouble(3,order.getMoney());
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean updateOrderMoney(Connection con,FgOrderVo orderVo){
        String sql="update fg_order set count=?,money=? where id=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,orderVo.getCount());
            pstmt.setDouble(2,orderVo.getPrice()*orderVo.getCount());
            pstmt.setInt(3,orderVo.getId());
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean updateOrderStatus(Connection con,FgOrder order){
        String sql="update fg_order set status=?,p_id=? where id=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(order.getStatus()));
            pstmt.setInt(2, order.getpId());
            pstmt.setInt(3,order.getId());
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }
    //显示购物车（status=0）
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
    //显示订单（status<>0）
    public List<FgOrderVo> listFgOrderVo1(Connection con,Integer userId,Integer startNUm,Integer pageNum){
        String sql="select fg_order.id as id,payId,payType,status,sushe,phone from fg_pay,fg_order,fg_user where fg_order.p_id=fg_pay.id and fg_order.user_id=fg_user.id and status <> 0 and user_id=?  order by id DESC limit ?,?";
        List lists=new ArrayList<FgOrderVo>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,userId);
            pstmt.setInt(2,startNUm);
            pstmt.setInt(3,pageNum);
            rs=pstmt.executeQuery();
            while(rs.next()){
                FgOrderVo fgOrderVo=new FgOrderVo();
                fgOrderVo.setId(rs.getInt("id"));
                fgOrderVo.setPayId(rs.getString("payId"));
                switch (rs.getShort("payType")) {
                    case 0: {
                       fgOrderVo.setPayType("在线支付");break; //判断管理员登录后台
                    }
                    case 1: {
                       fgOrderVo.setPayType("现金支付");break; //查询所有的管理员信息
                    }
                }
                switch (rs.getShort("status")) {
                    case 1: {
                        fgOrderVo.setStatus("未发货");break; //判断管理员登录后台
                    }
                    case 2: {
                        fgOrderVo.setStatus("已发货");break; //查询所有的管理员信息
                    }
                }
                fgOrderVo.setSuShe(rs.getString("suShe"));
                fgOrderVo.setPhone(rs.getString("phone"));
                lists.add(fgOrderVo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }
    //显示订单详细
    public FgOrderVo listFgOrderVo2(Connection con,Integer orderId){
        String sql="select fg_order.id as id,payId,goodName,price,count,money, payTime from bg_good,fg_order,fg_pay where fg_order.good_id=bg_good.id and fg_order.p_id=fg_pay.id  and fg_order.id=? order by id DESC";
        FgOrderVo fgOrderVo=null;
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,orderId);
            rs=pstmt.executeQuery();
            while(rs.next()){
                fgOrderVo=new FgOrderVo();
                fgOrderVo.setId(rs.getInt("id"));
                fgOrderVo.setPayId(rs.getString("payId"));
                try {
                    fgOrderVo.setPayTime(DateUtil.formatDate(DateUtil.formatString(rs.getString("payTime"),"yyyyMMddHHmm"),"yyyy-MM-dd HH:mm"));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                fgOrderVo.setGoodName(rs.getString("goodName"));
                fgOrderVo.setPrice(rs.getDouble("price"));
                fgOrderVo.setCount(rs.getInt("count"));
                fgOrderVo.setMoney(rs.getDouble("money"));
                return fgOrderVo;

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fgOrderVo;
    }
    //显示所有订单
    public List<FgOrderVo> listFgOrderVo3(Connection con,Integer startNUm,Integer pageNum){
        String sql="select fg_order.id as id,payId,payType,status,userName,sushe,phone from fg_pay,fg_order,fg_user where fg_order.p_id=fg_pay.id and fg_order.user_id=fg_user.id and status <> 0 order by id DESC limit ?,?";
        List lists=new ArrayList<FgOrderVo>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,startNUm);
            pstmt.setInt(2,pageNum);
            rs=pstmt.executeQuery();
            while(rs.next()){
                FgOrderVo fgOrderVo=new FgOrderVo();
                fgOrderVo.setId(rs.getInt("id"));
                fgOrderVo.setUserName(rs.getString("userName"));
                fgOrderVo.setPayId(rs.getString("payId"));
                switch (rs.getShort("payType")) {
                    case 0: {
                        fgOrderVo.setPayType("在线支付");break; //判断管理员登录后台
                    }
                    case 1: {
                        fgOrderVo.setPayType("现金支付");break; //查询所有的管理员信息
                    }
                }
                switch (rs.getShort("status")) {
                    case 1: {
                        fgOrderVo.setStatus("未发货");break; //判断管理员登录后台
                    }
                    case 2: {
                        fgOrderVo.setStatus("已发货");break; //查询所有的管理员信息
                    }
                }
                fgOrderVo.setSuShe(rs.getString("suShe"));
                fgOrderVo.setPhone(rs.getString("phone"));
                lists.add(fgOrderVo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }

    public Integer getNum(Connection con,Integer userId) {
        String sql = "select count(*) from fg_order where user_id=? and status <>0";
        PreparedStatement pstmt = null;
        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1,userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count(*)");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    public Integer getNum(Connection con) {
        String sql = "select count(*) from fg_order where  status <>0";
        PreparedStatement pstmt = null;
        try {
            pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("count(*)");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public short getGoodType(Connection con,Integer userId) {
        String sql = "select type from bg_good,fg_order where bg_good.id=fg_order.good_id  and user_id=? order by fg_order.id DESC limit 0,1";
        PreparedStatement pstmt = null;
        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1,userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getShort("type");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean deleteFgOrder(Connection con,Integer id){
        String sql="delete  from fg_order where id=?";
        PreparedStatement pstmt=null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,id);
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    public short getStatus(Connection con,Integer id){
        String sql = "select status from fg_order where id=? ";
        PreparedStatement pstmt = null;
        try {
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1,id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getShort("status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }




    public boolean updateOrderStatus1(Connection con,FgOrder order){
        String sql="update fg_order set status=? where id=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(order.getStatus()));
            pstmt.setInt(2,order.getId());
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

}
