package com.hongzhi.zswh.app_v5.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hongzhi.zswh.app_v5.entity.AdvertisementEntity;
import com.hongzhi.zswh.app_v5.entity.AdvertisementImageEntity;


/**   Twitter : @taylorwang789 
 * Creat time : Jun 1, 2016    9:58:25 AM
 */
public interface V5AdDao {

    /**   Twitter : @taylorwang789 
     * Creat time : Jun 1, 2016    10:08:49 AM
     * @param ad_id
     * @return
     */
    List<AdvertisementImageEntity> imageListByAdId(Integer ad_id);

    /**   Twitter : @taylorwang789 
     * Creat time : Jun 2, 2016    1:21:34 PM
     * @param hOME_MIN
     * @param hOME_MAX
     * @return
     */
    List<AdvertisementEntity> homeAdList(@Param("localMin") Integer hOME_MIN, @Param("localMax") Integer hOME_MAX);

    /**   Twitter : @taylorwang789 
     * Creat time : Jun 2, 2016    1:30:48 PM
     * @param ad_id_list
     * @return
     */
    List<AdvertisementImageEntity> imageListByAdIdList(@Param("idList") List<Integer> ad_id_list);

}
