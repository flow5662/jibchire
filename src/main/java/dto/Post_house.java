package dto;

public class Post_house {
	/* foreign key 있을 때는 insert할때 해당 테이블에 진짜 값이 있는지 확인해야만 한다
	 * insert into post_house (post_id,cust_id,post_title,post_txt,post_house,
post_rooms,post_m2,post_fam,post_houseold,post_budget,post_family,post_direc,post_region,
post_pet,post_startdate,post_enddate,post_pics,post_style,post_color
) values(default,'jessie','우리집을 소개합니다','헤헤 좋죠','아파트',
2,24,2,5,1000,'반려동물과','남동향','송파구',
'y',20230202,20230303,'src=ggg.jpg','colorful,minimal','red,green');
	 * */
	
	// 추가 : 작성일, 그리고 사진 +설명, 사진+설명 이런식으로 가야할 수도 있다
	public int post_id;  //auto increment
	public String cust_id; // cust_info테이블에 이미 들어가있는 데이터여야만 한다는 걸 주의!!!
	public String post_title; //게시글 제목
	public String post_txt;  //게시글 내용
	public String post_house; //주거형태

	public int post_rooms; // 방의 갯수
	public int post_m2;  //집 평수
	public int post_fam; //가족인원수
	public int post_houseold; //집 연식
	public int post_budget; // 예산
	
	public String post_family; //가족형태 (1인가구 등등)
	public String post_direc; //집의 방향
	public String post_region; //지역
	public String post_pet; // char y or n
	public String post_startdate; //공사시작일
	public String post_enddate; //공사마감일
	public String post_style; // 컬러풀,등등
	public String post_color; // 색상 00,00,00,
	public String post_pics; // 이미지 루트?
	public String post_pic1;
	public String post_pic2;
	public String post_pic3;
	public String post_writetime;
	public String bookmark_time;
	
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getCust_id() {
		return cust_id;
	}
	public void setCust_id(String cust_id) {
		this.cust_id = cust_id;
	}
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	public String getPost_txt() {
		return post_txt;
	}
	public void setPost_txt(String post_txt) {
		this.post_txt = post_txt;
	}
	public String getPost_house() {
		return post_house;
	}
	public void setPost_house(String post_house) {
		this.post_house = post_house;
	}
	public int getPost_rooms() {
		return post_rooms;
	}
	public void setPost_rooms(int post_rooms) {
		this.post_rooms = post_rooms;
	}
	public int getPost_m2() {
		return post_m2;
	}
	public void setPost_m2(int post_m2) {
		this.post_m2 = post_m2;
	}
	public int getPost_fam() {
		return post_fam;
	}
	public void setPost_fam(int post_fam) {
		this.post_fam = post_fam;
	}
	public int getPost_houseold() {
		return post_houseold;
	}
	public void setPost_houseold(int post_houseold) {
		this.post_houseold = post_houseold;
	}
	public int getPost_budget() {
		return post_budget;
	}
	public void setPost_budget(int post_budget) {
		this.post_budget = post_budget;
	}
	public String getPost_family() {
		return post_family;
	}
	public void setPost_family(String post_family) {
		this.post_family = post_family;
	}
	public String getPost_direc() {
		return post_direc;
	}
	public void setPost_direc(String post_direc) {
		this.post_direc = post_direc;
	}
	public String getPost_region() {
		return post_region;
	}
	public void setPost_region(String post_region) {
		this.post_region = post_region;
	}
	public String getPost_pet() {
		return post_pet;
	}
	public void setPost_pet(String post_pet) {
		this.post_pet = post_pet;
	}
	public String getPost_startdate() {
		return post_startdate;
	}
	public void setPost_startdate(String post_startdate) {
		this.post_startdate = post_startdate;
	}
	public String getPost_enddate() {
		return post_enddate;
	}
	public void setPost_enddate(String post_enddate) {
		this.post_enddate = post_enddate;
	}
	public String getPost_pics() {
		return post_pics;
	}
	public void setPost_pics(String post_pics) {
		this.post_pics = post_pics;
	}
	public String getPost_style() {
		return post_style;
	}
	public void setPost_style(String post_style) {
		this.post_style = post_style;
	}
	public String getPost_color() {
		return post_color;
	}
	public void setPost_color(String post_color) {
		this.post_color = post_color;
	}
	public String getPost_pic1() {
		return post_pic1;
	}
	public void setPost_pic1(String post_pic1) {
		this.post_pic1 = post_pic1;
	}
	public String getPost_pic2() {
		return post_pic2;
	}
	public void setPost_pic2(String post_pic2) {
		this.post_pic2 = post_pic2;
	}
	public String getPost_pic3() {
		return post_pic3;
	}
	public void setPost_pic3(String post_pic3) {
		this.post_pic3 = post_pic3;
	}
	public String getPost_writetime() {
		return post_writetime;
	}
	public void setPost_writetime(String post_writetime) {
		this.post_writetime = post_writetime;
	}
	public String getBookmark_time() {
		return bookmark_time;
	}
	public void setBookmark_time(String bookmark_time) {
		this.bookmark_time = bookmark_time;
	}

	
	

}
