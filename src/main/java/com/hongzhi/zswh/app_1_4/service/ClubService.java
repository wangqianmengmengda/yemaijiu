package com.hongzhi.zswh.app_1_4.service;


import com.hongzhi.zswh.app_1_4.dao.ClubDao;
import com.hongzhi.zswh.app_1_4.entity.ClubManageEntity;
import com.hongzhi.zswh.app_1_4.entity.ClubQueryEntity;
import com.hongzhi.zswh.app_1_4.entity.UserDetailEntity;
import com.hongzhi.zswh.app_v3.notification.service.NotificationService;
import com.hongzhi.zswh.util.basic.DictionaryUtil;
import com.hongzhi.zswh.util.basic.ObjectUtil;
import com.hongzhi.zswh.util.basic.sessionDao.SessionProperty;
import com.hongzhi.zswh.util.exception.HongZhiException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service("app_1_4_ClubService")
public class ClubService {
    @Autowired
    private ClubDao clubDao;
    @Autowired
    private EventService eventService;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private DictionaryUtil dictionaryUtil;
    /**
     * @param property
     * @return
     * @throws HongZhiException
     */
    public Object loadClubManage(SessionProperty property) throws HongZhiException {

        ClubQueryEntity club_info = clubDao.clubInfo(Integer.parseInt(property.getUser_id()), property.getLanguage());

        if (ObjectUtil.isEmpty(club_info)) {
            club_info = new ClubQueryEntity();

        }

        ClubManageEntity out = new ClubManageEntity();

        List is_admin_list = clubDao.selectClubAdmin(club_info.getClub_id(), property.getUser_id());//查看是否是俱乐部管理员

        if (is_admin_list.size() == 0) {
            out.setShow_event("0");
            out.setShow_club("0");
            out.setUser_level("99");//普通会员
        } else {
            out.setUser_level("0");//管理员
            List<Integer> event_list =  clubDao.queryEvent(club_info.getClub_id());

            List<Integer> club_list =  clubDao.queryClub(club_info.getClub_id());

            if (event_list.size() > 0){
                out.setShow_event("1");
            }else{
                out.setShow_event("0");
            }

            if (club_list.size() > 0){
                out.setShow_club("1");
            }else{
                out.setShow_club("0");
            }
        }

        String defaultVal = "0";
        out.setClub_member_number(ObjectUtil.getProperty(club_info.getClub_member(), defaultVal).toString());
        out.setSports_camp_number(ObjectUtil.getProperty(club_info.getSports_camp(), defaultVal).toString());
        out.setJoin_club_status(ObjectUtil.getProperty(club_info.getJoin_club_status(), defaultVal).toString());
        out.setJoin_club_status_name(ObjectUtil.getProperty(club_info.getJoin_club_status_name(), "").toString());
        out.setActivity_number(defaultVal);
        out.setComplete_training_number(defaultVal);
        out.setContinuous_training_number(defaultVal);
        out.setTotal_training_number(defaultVal);
        out.setRanking(defaultVal);
        out.setComprehensive_integral(defaultVal);
        out.setMy_club_ranking(club_info.getMy_club_rank());
        out.setClub(clubDao.userClub(Integer.parseInt(property.getUser_id())));

        String club_id = "0";

        if (!ObjectUtil.isEmpty(club_info.getClub_id())) {
            club_id = club_info.getClub_id();
        }

        out.setClub_ranking_list(clubDao.clubRanking("   limit 3   ", Integer.parseInt(club_id)));
        out.setEvent((Map<String, Object>) eventService.latestEvent(property));
        Map<String, Object> map = new HashMap<>();
        map.put("club_interface_data", out);

        return map;
    }
    public Object loadClubManageNotLogIn() {

        ClubManageEntity out = new ClubManageEntity();
        String defaultVal = "0";
        out.setClub_member_number(defaultVal);
        out.setSports_camp_number(defaultVal);
        out.setJoin_club_status(defaultVal);
        out.setJoin_club_status_name(defaultVal);
        out.setActivity_number(defaultVal);
        out.setComplete_training_number(defaultVal);
        out.setContinuous_training_number(defaultVal);
        out.setTotal_training_number(defaultVal);
        out.setRanking(defaultVal);
        out.setComprehensive_integral(defaultVal);
        out.setMy_club_ranking(defaultVal);
        out.setClub(null);
        out.setClub_ranking_list(clubDao.clubRanking("   limit 3   ", 0));
        out.setShow_event("0");
        out.setShow_club("0");
        Map<String, Object> map = new HashMap<>();
        map.put("club_interface_data", out);
        return map;
    }

    public Object deleteMember(String user_id, SessionProperty property, String delete_reason) throws HongZhiException {

        if ("0".equals(property.getClub_user_level()) && !ObjectUtil.isEmpty(user_id)){

            List<Map<String, Objects>> list = clubDao.selectCompetitionByUserId(Integer.valueOf(user_id));
            if (list.size() > 0) {
                //不允许退出
                throw new HongZhiException("1077");
            }

            List<Map<String,Object>> event_list = clubDao.selectEvent(Integer.valueOf(user_id));

            if (event_list.size() > 0 ){

                throw new HongZhiException("1086");//有参见的活动，还没结束的活动，不能退出俱乐部
            }

            List<Integer> multiple_receiver = new ArrayList<>();
            multiple_receiver.add(Integer.valueOf(user_id));

            List<UserDetailEntity> user_detail_list = clubDao.queryClubInfo(multiple_receiver);

            clubDao.insetIntoUserDetail(user_detail_list);

            clubDao.clubUnbuild(multiple_receiver);

            Map<String,Object> club_map = clubDao.queryClubName(property.getClub_id());

            notificationService.sendNoti(1, multiple_receiver, null, "1", dictionaryUtil.getCodeValue("delete_member", "event", "zh")+club_map.get("club_name")+ dictionaryUtil.getCodeValue("delete_member_m", "event", "zh")+delete_reason);

        }
        return null;
    }
}
