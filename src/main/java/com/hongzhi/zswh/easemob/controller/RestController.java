package com.hongzhi.zswh.easemob.controller;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hongzhi.zswh.easemob.client.EASEMOB;
import com.hongzhi.zswh.easemob.service.RestService;
import com.hongzhi.zswh.util.basic.DictionaryUtil;
import com.hongzhi.zswh.util.basic.ObjectUtil;
import com.hongzhi.zswh.util.basic.SessionUtil;
import com.hongzhi.zswh.util.exception.HongZhiException;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import org.apache.http.HttpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created with IntelliJ IDEA.
 * User: xuejian
 * Date: 2016/8/17
 * Time: 15:06
 * To change this template use File | Settings | File Templates.
 */
@Controller("rest_controller")
@RequestMapping("/{version}/rest")
public class RestController {
    @Autowired
    private SessionUtil sess;
    @Autowired
    private DictionaryUtil dic;


    @Autowired
    private RestService restService;


    /**
     * 注册 IM 用户[单个]
     */
    @ResponseBody
    @RequestMapping(value = "/register_user")
    public String restRegister(String user_id,@PathVariable String version) throws HongZhiException {

        switch (version){
            case "v1.4":

                return ObjectUtil.jsonOut( restService.restRegister(user_id));
            default:
                return "404";
        }

    }

    /**
     * 注册 IM 用户[批量]
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/register_users")
    public String restRegisterUsers(@PathVariable String version) {

        switch (version){
            case "v1.4":

                return ObjectUtil.jsonOut( restService.restRegisterUsers());
            default:
                return "404";
        }

    }

    /**
     * 获取 IM 用户[单个]
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/query_user")
    public String queryUser(String user_name,@PathVariable String version) {

        switch (version){
            case "v1.4":

                return ObjectUtil.jsonOut( restService.queryUser(user_name));
            default:
                return "404";
        }



    }

    /**
     * 获取 IM 用户[批量]
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/query_users")
    public String queryUsers(@PathVariable String version) {

        switch (version){
            case "v1.4":

                return ObjectUtil.jsonOut( restService.queryUsers());
            default:
                return "404";
        }

    }

    /**
     * 分页查询用户
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/query_users_pages")
    public String queryUsersPages() {

        ClientResponse response = null;

        try {
            Client client = Client.create();

            WebResource webResource = client.resource(EASEMOB.URL + "/" + EASEMOB.ORG_NAME + "/" + EASEMOB.APP_NAME + "/" + EASEMOB.USERS + "?limit=2&cursor=LTU2ODc0MzQzOnNmdTlxdF9LRWVPaVFvMWlBZmc4S3c");

            response = webResource.accept("application/json").header(HttpHeaders.AUTHORIZATION, "Bearer " + "YWMttVPrkGTxEeaoO6HkDk8LjwAAAVfQoQohGardK6gIlFM3DoFiDB2-t2jxKEM").get(ClientResponse.class);

            if (response.getStatus() == 200) {
                JsonElement jelement = new JsonParser().parse(response.getEntity(String.class));
                JsonObject result = jelement.getAsJsonObject();

                System.out.print(result.get("uri").getAsString());
            }
        } catch (Exception e) {
            e.getMessage();
        } finally {

            if (response != null) {
                response.close();
            }
        }

        return "success";

    }

    /**
     * 查询用户在线状态
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/query_user_status")
    public String queryUserStatus(String user_name) {
        ClientResponse response = null;
        try {
            Client client = Client.create();

            WebResource webResource = client.resource(EASEMOB.URL + "/" + EASEMOB.ORG_NAME + "/" + EASEMOB.APP_NAME + "/" + EASEMOB.USERS + "/" + user_name + "/" + "status");

            response = webResource.accept("application/json").header(HttpHeaders.AUTHORIZATION, "Bearer " + "YWMttVPrkGTxEeaoO6HkDk8LjwAAAVfQoQohGardK6gIlFM3DoFiDB2-t2jxKEM").get(ClientResponse.class);

            if (response.getStatus() == 200) {
                JsonElement jelement = new JsonParser().parse(response.getEntity(String.class));
                JsonObject result = jelement.getAsJsonObject();

                System.out.print(result.get("uri").getAsString());
            }
        } catch (Exception e) {
            e.getMessage();
        } finally {

            if (response != null) {
                response.close();
            }
        }

        return "success";
    }

    /**
     * 强制用户下线
     *
     * @param user_name
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/disconnect")
    public String disconnect(String user_name) {
        ClientResponse response = null;
        try {
            Client client = Client.create();
            WebResource webResource = client.resource(EASEMOB.URL + "/" + EASEMOB.ORG_NAME + "/" + EASEMOB.APP_NAME + "/" + EASEMOB.USERS + "/" + user_name + "/" + "disconnect");
            response = webResource.accept("application/json").header(HttpHeaders.AUTHORIZATION, "Bearer " + "YWMttVPrkGTxEeaoO6HkDk8LjwAAAVfQoQohGardK6gIlFM3DoFiDB2-t2jxKEM").get(ClientResponse.class);

            if (response.getStatus() == 200) {
                JsonElement jelement = new JsonParser().parse(response.getEntity(String.class));
                JsonObject result = jelement.getAsJsonObject();

                System.out.print(result.get("uri").getAsString());
            } else if (404 == response.getStatus()) {
                //此用户不存在
            } else if (401 == response.getStatus()) {
                //未授权[无token、token错误、token过期]
            }

        } catch (Exception e) {
            e.getMessage();
        } finally {

            if (response != null) {
                response.close();
            }
        }
        return null;
    }
    @ResponseBody
    @RequestMapping(value = "/delete_user")
    public String deleteUser(String user_name,@PathVariable String version) {

        switch (version){
            case "v1.4":

                return ObjectUtil.jsonOut( restService.deleteUser(user_name));
            default:
                return "404";
        }

    }

    @ResponseBody
    @RequestMapping(value = "/delete_users")
    public String deleteUsers(@PathVariable String version) {

        switch (version){
            case "v1.4":

                return ObjectUtil.jsonOut( restService.deleteUsers());
            default:
                return "404";
        }

    }
}
