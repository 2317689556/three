package com.buba.boot1806a.pojo;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class itemDate {
    private String activitiesName;//机构名称
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date Createtime;//机构id号码
    private  Integer id;
    private Integer numActivities;
    private Integer numActual;
    private Float  implRate;
    private Integer implRanking;
    private Integer newClient;
    private Integer oldClient;
    private Integer yxClient;
    private Float money;

    @Override
    public String toString() {
        return "itemDate{" +
                "activitiesName='" + activitiesName + '\'' +
                ", Createtime=" + Createtime +
                ", id=" + id +
                ", numActivities=" + numActivities +
                ", numActual=" + numActual +
                ", implRate=" + implRate +
                ", implRanking=" + implRanking +
                ", newClient=" + newClient +
                ", oldClient=" + oldClient +
                ", yxClient=" + yxClient +
                ", money=" + money +
                '}';
    }

    public String getActivitiesName() {
        return activitiesName;
    }

    public void setActivitiesName(String activitiesName) {
        this.activitiesName = activitiesName;
    }

    public Date getCreatetime() {
        return Createtime;
    }

    public void setCreatetime(Date createtime) {
        Createtime = createtime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNumActivities() {
        return numActivities;
    }

    public void setNumActivities(Integer numActivities) {
        this.numActivities = numActivities;
    }

    public Integer getNumActual() {
        return numActual;
    }

    public void setNumActual(Integer numActual) {
        this.numActual = numActual;
    }

    public Float getImplRate() {
        return implRate;
    }

    public void setImplRate(Float implRate) {
        this.implRate = implRate;
    }

    public Integer getImplRanking() {
        return implRanking;
    }

    public void setImplRanking(Integer implRanking) {
        this.implRanking = implRanking;
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
}
