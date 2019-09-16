package com.buba.boot1806a.pojo;

public class tbUser {
	private Integer id;

	private String usercode;

	private String username;

	private String password;

	private String tel;

	private String phoneText;

	private String email;

	private String emailPWD;

	private String sex;

	private String level;

	private Integer deptId;

	private String areaId;

	private String areaCode;

	@Override
	public String toString() {
		return "tbUser{" +
				"id=" + id +
				", usercode='" + usercode + '\'' +
				", username='" + username + '\'' +
				", password='" + password + '\'' +
				", tel='" + tel + '\'' +
				", phoneText='" + phoneText + '\'' +
				", email='" + email + '\'' +
				", emailPWD='" + emailPWD + '\'' +
				", sex='" + sex + '\'' +
				", level='" + level + '\'' +
				", deptId=" + deptId +
				", areaId='" + areaId + '\'' +
				", areaCode='" + areaCode + '\'' +
				'}';
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPhoneText() {
		return phoneText;
	}

	public void setPhoneText(String phoneText) {
		this.phoneText = phoneText;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmailPWD() {
		return emailPWD;
	}

	public void setEmailPWD(String emailPWD) {
		this.emailPWD = emailPWD;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
}