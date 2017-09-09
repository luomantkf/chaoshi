package com.chaoshi.servlet;

import com.chaoshi.dao.BgGoodDao;
import com.chaoshi.dao.BgManagerDao;
import com.chaoshi.dao.FgOrderDao;
import com.chaoshi.model.BgGood;
import com.chaoshi.model.BgManager;
import com.chaoshi.model.FgOrder;
import com.chaoshi.model.FgUser;
import com.chaoshi.util.DbUtil;
import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 *商品的处理类
 */
public class BgGoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DbUtil dbUtil=new DbUtil();
    BgGoodDao goodDao=new BgGoodDao();
    FgOrderDao orderDao=new FgOrderDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-type", "text/html;charset=UTF-8");
        HttpSession session = null;
        Connection con = null;
        //action为1增加商品,ctype=1时为修改商品
        if (request.getParameter("action").equals("1")) {
            BgGood bgGood = new BgGood();
            if("1".equals(request.getParameter("ctype"))){
                if(request.getParameter("id")!=null){
                    bgGood.setId(Integer.parseInt(request.getParameter("id")));
                }
            }

            String uploadPath = request.getSession().getServletContext().getRealPath("/") + "/images/goodPic/";
            // 配置上传参数
            DiskFileItemFactory factory = new DiskFileItemFactory();
            // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
            factory.setSizeThreshold(1024 * 1024 * 10);
            // 设置临时存储目录
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

            ServletFileUpload upload = new ServletFileUpload(factory);

            // 设置最大文件上传值
            upload.setFileSizeMax(1024 * 1024 * 40);

            // 设置最大请求值 (包含文件和表单数据)
            upload.setSizeMax(1024 * 1024 * 3);

            // 如果目录不存在则创建
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            try {
                List<FileItem> formItems = upload.parseRequest(request);

                if (formItems != null && formItems.size() > 0) {
                    // 迭代表单数据
                    for (FileItem item : formItems) {
                        //处理在表单的数据
                        if (item.isFormField()) {
                            String name = item.getFieldName(); //获取form表单中name的id
                            if ("goodName".equals(name))
                                bgGood.setGoodName(item.getString("utf-8"));
                            else if ("price".equals(name)) {
                                bgGood.setPrice(Double.parseDouble(item.getString("utf-8")));
                            } else if ("type".equals(name)) {
                                bgGood.setType(item.getString("utf-8"));
                            }
                        }
                        // 处理不在表单中的字段
                        else {
                            String fileName = new File(item.getName()).getName();
                            String endName = fileName.substring(fileName.indexOf("."));   //后缀名
                            if (endName.equals(".jpg") || endName.equals(".gif") || endName.equals(".jpeg") || endName.equals(".bmp") || endName.equals(".png")) {

                            }
                            String filePath = (new Date()).getTime() + endName;
                            File storeFile = new File(uploadPath +filePath);
                            // 保存文件到硬盘
                            item.write(storeFile);
                            bgGood.setGoodPic("/images/goodPic/"+filePath);
                        }
                    }
                }
            } catch (Exception ex) {
                PrintWriter pw = response.getWriter();
                pw.print("<script>alert(\"error\");window.location.href=\"/jsp/fg/fg-memberRegister.jsp\"</script>");
                return;
            }
            try {
                con = dbUtil.getCon();
                if("1".equals(request.getParameter("ctype"))){
                    if (goodDao.updateBgGood(con, bgGood)) {
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"更改成功\");window.location.href=\"/jsp/bg/bg-goods.jsp\"</script>");
                        return;
                    } else {

                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-goods.jsp\"</script>");
                        return;
                    }
                }else {
                    if (goodDao.insertBgGood(con, bgGood)) {
                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"添加成功\");window.location.href=\"/jsp/bg/bg-goods.jsp\"</script>");
                        return;
                    } else {

                        PrintWriter pw = response.getWriter();
                        pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-goods.jsp\"</script>");
                        return;
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }




        //数据删除
        else if(request.getParameter("action").equals("2")){
            Integer id=Integer.parseInt(request.getParameter("id"));
            try {
                con = dbUtil.getCon();
                if (goodDao.deleteBgGood(con, id)) {

                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"删除成功\");window.location.href=\"/jsp/bg/bg-goods.jsp\"</script>");
                    return;
                } else {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/bg/bg-goods.jsp\"</script>");
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //分页显示商品
        else if(request.getParameter("action").equals("3")){
            HashMap<String,Object> result=new HashMap<String,Object>();
            try {
                con=dbUtil.getCon();
                Integer allPage=0;
                Integer startNUm=0;
                Integer pageNum=7;
                if(goodDao.getNum(con)!=-1){
                    allPage=goodDao.getNum(con);
                }
                Integer currentPage= null;
                try {
                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                startNUm=(currentPage-1)*pageNum;
                List<BgGood> list=null;
                if(request.getParameter("type")!=null){
                    pageNum=4;
                    if(request.getParameter("goodName")!=null){
                        String goodName=new String(request.getParameter("goodName").getBytes("iso8859-1"),"UTF-8");
                        if(goodDao.getNum(con,Short.parseShort(request.getParameter("type")),goodName)!=-1){
                            allPage=goodDao.getNum(con,Short.parseShort(request.getParameter("type")),goodName);
                        }
                        startNUm=(currentPage-1)*pageNum;
                        list=goodDao.listBgGood(con,startNUm,pageNum,Short.parseShort(request.getParameter("type")),goodName);
                    }else {
                        if(Integer.parseInt(request.getParameter("type"))==0){
                            list = goodDao.listBgGood(con, startNUm, pageNum);
                        }else{

                            if (goodDao.getNum(con, Short.parseShort(request.getParameter("type"))) != -1) {
                                allPage = goodDao.getNum(con, Short.parseShort(request.getParameter("type")));
                            }
                            startNUm = (currentPage - 1) * pageNum;
                            list=goodDao.listBgGood(con,startNUm,pageNum,Short.parseShort(request.getParameter("type")));
                        }
                    }

                }else {
                    list = goodDao.listBgGood(con, startNUm, pageNum);
                }
                result.put("pageNum",pageNum.toString());
                result.put("allNum",allPage.toString());
                result.put("model",list);
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    dbUtil.closeCon(con);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            //将map对象转换成json对象，引用了google相应的包
            Gson gson=new Gson();
            PrintWriter pw = response.getWriter();
            pw.write(gson.toJson(result));
            pw.close();
        }
        //商品图片展示
        else if(request.getParameter("action").equals("4")){
            request.setAttribute("imgUrl",request.getParameter("goodPic"));
            request.getRequestDispatcher("/jsp/bg/bg-goodPic.jsp").forward(request,response);
        }
        //前台根据类型显示相应的商品
        else if(request.getParameter("action").equals("5")){
            String str=request.getParameter("goodName");
            if(request.getParameter("goodName")!=null&&!request.getParameter("goodName").equals("")){
                request.setAttribute("goodName",request.getParameter("goodName"));
            }
            request.setAttribute("type",request.getParameter("type"));
            request.getRequestDispatcher("/jsp/fg/fg-goodsType.jsp").forward(request,response);
        }
        //将商品加入购物车
        else if(request.getParameter("action").equals("6")){
            session=request.getSession();
            FgOrder order=new FgOrder();
            order.setUserId(((FgUser) session.getAttribute("currentUser")).getId());
            FgUser user=(FgUser) session.getAttribute("currentUser");
            order.setGoodId(Integer.parseInt(request.getParameter("id")));
            order.setMoney(Double.parseDouble(request.getParameter("price")));
            try {
                con = dbUtil.getCon();
                if (orderDao.insertFgOrder(con, order)) {
                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"添加成功\");window.location.href=\"/jsp/index.jsp\"</script>");
                    return;
                } else {

                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"error\");window.location.href=\"/jsp/index.jsp\"</script>;");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        //修改商品
        else if(request.getParameter("action").equals("7")){
            int id=Integer.parseInt(request.getParameter("id"));

            try {
                con = dbUtil.getCon();
                BgGood bgGood=goodDao.selectById(con,id);
                if(bgGood!=null){
                    request.setAttribute("bgGood",bgGood);
                    request.getRequestDispatcher("/jsp/bg/bg-editGoods.jsp").forward(request,response);
                } else {

                    PrintWriter pw = response.getWriter();
                    pw.print("<script>alert(\"该商品部存在\");window.location.href=\"/jsp/bg/bg-goods.jsp\"</script>;");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        }


    }
}

