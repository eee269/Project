package member;

import java.sql.Timestamp;

public class MemberBean {
	private String id;
	private String pass;
	private String name;
	private Timestamp date;

	private int age;

	private String gender;
	private String email;
	private String postcode;
	private String address1;
	private String address2;
	private String phone;

	private int emailHash;
	private boolean emailChecked;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getEmailHash() {
		return emailHash;
	}

	public void setEmailHash(int emailHash) {
		this.emailHash = emailHash;
	}

	public boolean isEmailChecked() {
		return emailChecked;
	}

	public void setEmailChecked(boolean emailChecked) {
		this.emailChecked = emailChecked;
	}

}
