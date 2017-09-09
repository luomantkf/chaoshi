package com.chaoshi.dao;

import com.chaoshi.model.BgManager;
import com.chaoshi.util.MD5Util;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/1/29.
 */
public class BgManagerDao {
    public  boolean insertBgManager(Connection con, com.chaoshi.model.BgManager user){
        String sql="insert into  bg_manager(userName,password,phone) values(?,?,?)";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, MD5Util.EncoderPwdByMd5(user.getPassword()));
            pstmt.setString(3,user.getPhone());
            if(pstmt.executeUpdate()==1){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return false;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    /**
     *
     * @param con
     * @return
     */

    public Integer getNum(Connection con) {
        String sql = "select count(*) from bg_manager ";
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

    /**
     *
     * @param con
     * @param start
     * @param end
     * @return
     */

    public List<BgManager> listBgManager(Connection con,Integer start,Integer end){
        String sql="select id,userName,phone from bg_manager order by id DESC limit ?,? ";
        List lists=new ArrayList<BgManager>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,start);
            pstmt.setInt(2,end);
            rs=pstmt.executeQuery();
            while(rs.next()){
                BgManager bgUser=new BgManager();
                bgUser.setId(rs.getInt("id"));
                bgUser.setUserName(rs.getString("userName"));
                bgUser.setPhone(rs.getString("phone"));

                lists.add(bgUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }
    public boolean deleteBgManager(Connection con,Integer id){
        String sql="delete  from bg_manager where id=?";
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
    public Integer loginManager(Connection con,BgManager user){
        String sql="select id from bg_manager where userName=? and password=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setString(1,user.getUserName());
            try {
                pstmt.setString(2,MD5Util.EncoderPwdByMd5(user.getPassword()));
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

            ResultSet rs=pstmt.executeQuery();
            while(rs.next()){
                return rs.getInt("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    public boolean loginManager(Connection con,String userName){
        String sql="select id from fg_user where userName=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setString(1,userName);

            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
