package com.chaoshi.dao;

import com.chaoshi.model.BgManager;
import com.chaoshi.model.FgUser;
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
 * Created by Administrator on 2017/1/21.
 */
public class FgUserDao {
    public  Integer insertFgUser(Connection con,FgUser user){
        String sql="insert into  fg_user(userName,password,grade,sushe,phone) values(?,?,?,?,?)";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, MD5Util.EncoderPwdByMd5(user.getPassword()));
            pstmt.setString(3,user.getGrade());
            pstmt.setString(4,user.getSushe());
            pstmt.setString(5,user.getPhone());
            if(pstmt.executeUpdate()==1){
                ResultSet rs=pstmt.getGeneratedKeys();
                if(rs.next()){
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return -1;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }
    public Integer loginFgUser(Connection con,FgUser user){
        String sql="select id from fg_user where userName=? and password=?";
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
    public boolean loginFgUser(Connection con,String userName){
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
    public Integer getNum(Connection con) {
        String sql = "select count(*) from fg_user ";
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
    public List<FgUser> listFgUser(Connection con,Integer start,Integer end){
        String sql="select id,userName,grade,sushe,phone from fg_user order by id DESC limit ?,? ";
        List lists=new ArrayList<FgUser>();
        ResultSet rs=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,start);
            pstmt.setInt(2,end);
            rs=pstmt.executeQuery();
            while(rs.next()){
                FgUser fgUser=new FgUser();
                fgUser.setId(rs.getInt("id"));
                fgUser.setUserName(rs.getString("userName"));
                fgUser.setGrade(rs.getString("grade"));
                fgUser.setSushe(rs.getString("sushe"));
                fgUser.setPhone(rs.getString("phone"));

                lists.add(fgUser);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lists;
    }
    public FgUser selectFgUserById(Connection con,Integer id){
        String sql="select id,userName,grade,sushe,phone from fg_user where id=? ";
        ResultSet rs=null;
        FgUser fgUser=null;
        PreparedStatement pstmt = null;
        try {
            pstmt=con.prepareStatement(sql);
            pstmt.setInt(1,id);
            rs=pstmt.executeQuery();
            while(rs.next()){
                fgUser=new FgUser();
                fgUser.setId(rs.getInt("id"));
                fgUser.setUserName(rs.getString("userName"));
                fgUser.setGrade(rs.getString("grade"));
                fgUser.setSushe(rs.getString("sushe"));
                fgUser.setPhone(rs.getString("phone"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fgUser;
    }

    public boolean deleteBgUser(Connection con,Integer id){
        String sql="delete  from fg_user where id=?";
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
    public boolean updateUserById(Connection con,FgUser user){
        String sql="update fg_user set grade=? , sushe=? , phone=? where id=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(sql);
            pstmt.setString(1,user.getGrade());
            pstmt.setString(2,user.getSushe());
            pstmt.setString(3,user.getPhone());
            pstmt.setInt(4,user.getId());
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
