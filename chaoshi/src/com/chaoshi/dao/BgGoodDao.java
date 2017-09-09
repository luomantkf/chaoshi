package com.chaoshi.dao;

import com.chaoshi.model.BgGood;
import com.chaoshi.model.BgGoodVo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/1/21.
 */
public class BgGoodDao {
    public  boolean insertBgGood(Connection con,BgGood good){
        String sql="insert into  bg_good(goodName,price,type,goodPic) values(?,?,?,?)";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setString(1, good.getGoodName());
            pstmt.setDouble(2, good.getPrice());
            pstmt.setShort(3,Short.parseShort(good.getType()));
            pstmt.setString(4,good.getGoodPic());
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }
    public  boolean updateBgGood(Connection con,BgGood good){
        String sql="update bg_good set goodName=?,price=?,type=?,goodPic=? where id=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setString(1, good.getGoodName());
            pstmt.setDouble(2, good.getPrice());
            pstmt.setShort(3,Short.parseShort(good.getType()));
            pstmt.setString(4,good.getGoodPic());
            pstmt.setInt(5,good.getId());
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }
    public List<BgGood> listBgGood(Connection con,Integer start,Integer end){
        String sql="select id,goodName,price,type,goodPic from bg_good order by id DESC limit ?,? ";
        List lists=new ArrayList<BgGood>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,start);
            pstmt.setInt(2,end);
            rs=pstmt.executeQuery();
            while(rs.next()){
                BgGood bgGood=new BgGood();
                bgGood.setId(rs.getInt("id"));
                bgGood.setGoodName(rs.getString("goodName"));
                bgGood.setPrice(rs.getDouble("price"));
                switch (rs.getShort("type")) {
                    case 1: {
                        bgGood.setType("小吃");break;
                    }
                    case 2: {
                        bgGood.setType("饮料");break;
                    }
                    case 3: {
                        bgGood.setType("日常用品");break;
                    }
                    case 4: {
                        bgGood.setType("文具");break;
                    }
                    case 5: {
                        bgGood.setType("电子商品");break;
                    }
                }
                bgGood.setGoodPic(rs.getString("goodPic"));

                lists.add(bgGood);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }
    public List<BgGood> listBgGood(Connection con,Integer start,Integer end,short type){
        String sql="select id,goodName,price,type,goodPic from bg_good where type="+type+" order by id DESC limit ?,? ";
        List lists=new ArrayList<BgGood>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,start);
            pstmt.setInt(2,end);
            rs=pstmt.executeQuery();
            while(rs.next()){
                BgGood bgGood=new BgGood();
               bgGood.setId(rs.getInt("id"));
                bgGood.setGoodName(rs.getString("goodName"));
                bgGood.setPrice(rs.getDouble("price"));
                switch (rs.getShort("type")) {
                    case 1: {
                        bgGood.setType("小吃");break;
                    }
                    case 2: {
                        bgGood.setType("饮料");break;
                    }
                    case 3: {
                        bgGood.setType("日常用品");break;
                    }
                    case 4: {
                        bgGood.setType("文具");break;
                    }
                    case 5: {
                        bgGood.setType("电子商品");break;
                    }
                }
                bgGood.setGoodPic(rs.getString("goodPic"));

                lists.add(bgGood);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }
    public List<BgGood> listBgGood(Connection con,Integer start,Integer end,short type,String goodName){
        String sql="";
        if(type==0){
            sql="select id,goodName,price,type,goodPic from bg_good where goodName like \'%"+goodName+"%\' order by id DESC limit ?,? ";
        }
        else{
            sql="select id,goodName,price,type,goodPic from bg_good where type="+type+" and goodName like \'%"+goodName+"%\' order by id DESC limit ?,? ";
        }
        List lists=new ArrayList<BgGood>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,start);
            pstmt.setInt(2,end);
            rs=pstmt.executeQuery();
            while(rs.next()){
                BgGood bgGood=new BgGood();
                bgGood.setId(rs.getInt("id"));
                bgGood.setGoodName(rs.getString("goodName"));
                bgGood.setPrice(rs.getDouble("price"));
                switch (rs.getShort("type")) {
                    case 1: {
                        bgGood.setType("小吃");break;
                    }
                    case 2: {
                        bgGood.setType("饮料");break;
                    }
                    case 3: {
                        bgGood.setType("日常用品");break;
                    }
                    case 4: {
                        bgGood.setType("文具");break;
                    }
                    case 5: {
                        bgGood.setType("电子商品");break;
                    }
                }
                bgGood.setGoodPic(rs.getString("goodPic"));

                lists.add(bgGood);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }

    public BgGood selectById(Connection con,Integer id){

        String sql="select id,goodName,price,type,goodPic from bg_good where id=?";

        List lists=new ArrayList<BgGood>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        BgGood bgGood=null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,id);
            rs=pstmt.executeQuery();
            while(rs.next()){
                bgGood=new BgGood();
                bgGood.setId(rs.getInt("id"));
                bgGood.setGoodName(rs.getString("goodName"));
                bgGood.setPrice(rs.getDouble("price"));
                switch (rs.getShort("type")) {
                    case 1: {
                        bgGood.setType("小吃");break;
                    }
                    case 2: {
                        bgGood.setType("饮料");break;
                    }
                    case 3: {
                        bgGood.setType("日常用品");break;
                    }
                    case 4: {
                        bgGood.setType("文具");break;
                    }
                    case 5: {
                        bgGood.setType("电子商品");break;
                    }
                }
                bgGood.setGoodPic(rs.getString("goodPic"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bgGood;

    }
    public Integer getNum(Connection con) {
        String sql = "select count(*) from bg_good ";
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
        return 0;
    }

    public Integer getNum(Connection con,short type) {
        String sql = "select count(*) from bg_good where type="+type+"";
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
    public Integer getNum(Connection con,short type,String goodName) {
        String sql="";
        if(type==0){
            sql="select count(*) from bg_good where goodName like \'%"+goodName+"%\' ";
        }
        else{
            sql = "select count(*) from bg_good where type="+type+" and goodName like \'%"+goodName+"%\'";
        }
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




    public boolean deleteBgGood(Connection con,Integer id){
        String sql="delete  from bg_good where id=?";
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
    //查出销售量最高的五种商品
    public List<BgGoodVo> selectHighCount(Connection con,Integer start,Integer end){
        String sql="SELECT goodName,sum(count) as count1  from bg_good,fg_order where fg_order.good_id=bg_good.id GROUP BY fg_order.good_id  DESC limit ?,?";
        List lists=new ArrayList<BgGood>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,start);
            pstmt.setInt(2,end);
            rs=pstmt.executeQuery();
            while(rs.next()){
                BgGoodVo  bgGoodVo=new BgGoodVo();
                bgGoodVo.setGoodName(rs.getString("goodName"));
                bgGoodVo.setSaleCount(rs.getInt("count1"));
                lists.add(bgGoodVo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }

}
