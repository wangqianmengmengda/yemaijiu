package com.hongzhi.zswh.app_1_4.dao;



import com.hongzhi.zswh.app_1_4.entity.ClubQueryEntity;
import com.hongzhi.zswh.app_1_4.entity.UserDetailEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Repository("app_1_4_ClubDao")
public interface ClubDao {

    ClubQueryEntity clubInfo(@Param("userId") int userId, @Param("language") String language);

    List selectClubAdmin(@Param("club_id") String club_id, @Param("user_id") String user_id);

    Map<String, Object> userClub(int user_id);

    List<Map<String,Object>> clubRanking(@Param("limitSql") String limitSql, @Param("userClubId") int userClubId);

    List<Map<String,Object>>  listClub();

    List<Integer> queryEvent(String club_id);

    List<Integer> queryClub(String club_id);

    List<UserDetailEntity> queryClubInfo( @Param("multipleReceiver")List<Integer> multiple_receiver);

    void insetIntoUserDetail(@Param("detailList") List<UserDetailEntity> user_detail_list);

    void clubUnbuild(@Param("reciver") List<Integer> multiple_receiver);

    List<Map<String,Objects>> selectCompetitionByUserId(Integer user_id);

    List<Map<String,Object>> selectEvent(Integer user_id);

    Map<String,Object> queryClubName(Integer club_id);
}
