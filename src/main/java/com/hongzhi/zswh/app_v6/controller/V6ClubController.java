package com.hongzhi.zswh.app_v6.controller;

import com.hongzhi.zswh.app_v6.service.V6ClubService;
import com.hongzhi.zswh.util.basic.DictionaryUtil;
import com.hongzhi.zswh.util.basic.ObjectUtil;
import com.hongzhi.zswh.util.basic.SessionUtil;
import com.hongzhi.zswh.util.basic.sessionDao.SessionProperty;
import com.hongzhi.zswh.util.exception.HongZhiException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by XieCaij on 2016/6/28.
 */
@Controller
@RequestMapping("/v6/club")
public class V6ClubController {
    @Autowired
    private V6ClubService clubService;
    @Autowired
    private SessionUtil sess;
    @Autowired
    private DictionaryUtil dic;
    @ResponseBody
    @RequestMapping("/outofclub")
    public String OutOfClub(HttpSession session, String session_id, String  club_id){
        SessionProperty properties ;
        String language = "zh";
        try {
            properties = sess.sessionEffective(session,session_id , "/v6/club/outofclub");
            language = properties.getLanguage();
            return ObjectUtil.jsonOut( clubService.OutOfClub(club_id,properties.getUser_id()));
        } catch (HongZhiException e) {
            return ObjectUtil.jsonOutError(e.getCode(), dic.getCodeValue(e.getCode(), language ) );
        }
    }



/*    @ResponseBody
    @RequestMapping("/upClubPic")
    public String saveClubPic(HttpSession session, String session_id, String picUrl, String club_id){

        SessionProperty properties ;
        String language = "zh";
        try {
            properties = sess.sessionEffective(session,session_id , "/v6/club/upClubPic");
            language = properties.getLanguage();
            return ObjectUtil.jsonOut( clubService.saveClubPic(picUrl,club_id,properties.getUser_id()) );
        } catch (HongZhiException e) {
            return ObjectUtil.jsonOutError(e.getCode(), dic.getCodeValue(e.getCode(), language ) );
        }

    }*/

    @ResponseBody
    @RequestMapping("/picUpload")  //  picutre upload
    public String  springUpload(HttpServletRequest request,HttpSession session, String session_id,String club_id) throws IllegalStateException, IOException {
        SessionProperty properties ;
        String language = "zh";
        try {
            properties = sess.sessionEffective(session,session_id , "/v6/club/upClubPic");
            language = properties.getLanguage();
            return ObjectUtil.jsonOut( clubService.saveClubPic(request,club_id,properties.getUser_id()) );
        } catch (HongZhiException e) {
            return ObjectUtil.jsonOutError(e.getCode(), dic.getCodeValue(e.getCode(), language ) );
        }
    }
    @ResponseBody
    @RequestMapping("/transferClub")
    //管理员转让俱乐部权限，成为普通会员
    public String transferClub(HttpSession session, String session_id, String user_id, String club_id){

        SessionProperty properties ;
        String language = "zh";
        try {
            properties = sess.sessionEffective(session,session_id , "/v6/club/transferClub");
            language = properties.getLanguage();
            String userId =  properties.getUser_id();
            return ObjectUtil.jsonOut( clubService.transferClub(user_id,club_id,userId) );
        } catch (HongZhiException e) {
            return ObjectUtil.jsonOutError(e.getCode(), dic.getCodeValue(e.getCode(), language ) );
        }

    }

}
