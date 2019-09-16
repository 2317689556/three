package com.buba.boot1806a.pojo;
import java.io.Serializable;
import java.util.Date;

public class Items implements Serializable {
    private Integer id;

    private Integer planId;

    private String activitiesName;

    private Integer numActivities;

    private Integer numActual;

    private Double zhixinglv;

    private Integer newClient;

    private Integer oldClient;

    private Integer yxClient;

    private Float money;

    private String available;

    private Date createtime;

    private Date autoTimestamp;

    private Integer deptId;

    private String deptName;

    private Integer areaId;

    private String areaCode;

    private Integer userId;

    private String userCode;

    private static final long serialVersionUID = 1L;

    public Integer getNumActivities() {
        return numActivities;
    }

    public void setNumActivities(Integer numActivities) {
        this.numActivities = numActivities;
    }

    public Double getZhixinglv() {

        return this.zhixinglv;
    }

    public void setZhixinglv(Double zhixinglv) {
        this.zhixinglv = zhixinglv;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Integer getPlanId() {
        return planId;
    }

    public void setPlanId(Integer planId) {
        this.planId = planId;
    }

    public String getActivitiesName() {
        return activitiesName;
    }

    public void setActivitiesName(String activitiesName) {
        this.activitiesName = activitiesName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNumActual() {
        return numActual;
    }

    public void setNumActual(Integer numActual) {
        this.numActual = numActual;
    }

    public Integer getNewClient() {
        return newClient;
    }

    public void setNewClient(Integer newClient) {
        this.newClient = newClient;
    }

    public Integer getOldClient() {
        return oldClient;
    }

    public void setOldClient(Integer oldClient) {
        this.oldClient = oldClient;
    }

    public Integer getYxClient() {
        return yxClient;
    }

    public void setYxClient(Integer yxClient) {
        this.yxClient = yxClient;
    }

    public Float getMoney() {
        return money;
    }

    public void setMoney(Float money) {
        this.money = money;
    }

    public String getAvailable() {
        return available;
    }

    public void setAvailable(String available) {
        this.available = available == null ? null : available.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getAutoTimestamp() {
        return autoTimestamp;
    }

    public void setAutoTimestamp(Date autoTimestamp) {
        this.autoTimestamp = autoTimestamp;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode == null ? null : areaCode.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode == null ? null : userCode.trim();
    }

    @Override
    public String toString() {
        return "Items [id=" + id + ", planId=" + planId + ", activitiesName=" + activitiesName + ", numActivities="
                + numActivities + ", numActual=" + numActual + ", zhixinglv=" + zhixinglv + ", newClient=" + newClient
                + ", oldClient=" + oldClient + ", yxClient=" + yxClient + ", money=" + money + ", available="
                + available + ", createtime=" + createtime + ", autoTimestamp=" + autoTimestamp + ", deptId=" + deptId
                + ", deptName=" + deptName + ", areaId=" + areaId + ", areaCode=" + areaCode + ", userId=" + userId
                + ", userCode=" + userCode + "]";
    }
}
