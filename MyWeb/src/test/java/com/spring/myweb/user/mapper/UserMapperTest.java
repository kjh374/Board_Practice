package com.spring.myweb.user.mapper;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.time.LocalDateTime;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.myweb.user.entity.User;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/db-config.xml")
public class UserMapperTest {

	@Autowired
	private IUserMapper mapper;
	
	@Test
    @DisplayName("회원 가입을 진행했을 때 회원가입이 성공해야 한다.")
    void registTest() {
        User user = User.builder()
        				.userId("userId4").userPw("userPw")
        				.userName("userName").userPhone1("userPhone1")
//        				.userPhone2("userPhone2").userEmail1("userEmail1")
//        				.userEmail2("userEmail2").addrBasic("addrBasic")
        				.addrDetail("addrDetail").addrZipNum("addrZipNum")
        				.build();
//        User user = User.builder()
//				.userId("abc1234").userPw("aaa1111!")
//				.userName("userName").userPhone1("userPhone1")
//				.userPhone2("userPhone2").userEmail1("userEmail1")
//				.userEmail2("userEmail2").addrBasic("addrBasic")
//				.addrDetail("addrDetail").addrZipNum("addrZipNum")
//				.build();
        
        mapper.join(user);
        
//        assertEquals(mapper.getInfo(user.getUserId()), user);
    }
    
    @Test
    @DisplayName("존재하는 회원 아이디를 조회했을 시 1이 리턴되어야 한다.")
    void checkIdTest() {
        String userId = "userId";
        
        assertEquals(mapper.idCheck(userId), 1);
    }
    
    @Test
    @DisplayName("존재하는 회원 아이디를 입력 했을 시 그 회원의 비밀번호가 리턴되어야 한다.")
    void loginTest() {
        String userId = "userId";
        String userPw = "userPw";
        
        assertEquals(mapper.login(userId), userPw);
        assertNotNull(mapper.login(userId));
    }
    
    @Test
    @DisplayName("존재하지 않는 회원의 아이디를 전달하면 null이 올 것이다.")
    void getInfoTest() {
        String userId = "유령회원";
        
        assertNull(mapper.getInfo(userId));
    }
    
    @Test
    @DisplayName("id를 제외한 회원의 정보를 수정할 수 있어야 한다.")
    void updateTest() {
    	User user = User.builder()
    					.userId("userId").userPw("userPw")
    					.userName("userName").userEmail1("userEmail1")
//    					.userEmail2("userEmail2").addrBasic("addrBasic")
    					.addrDetail("addrDetail").addrZipNum("addrZipNum")
    					.build();
    	mapper.updateUser(user);
    	assertEquals(mapper.getInfo(user.getUserId()).getUserEmail1(), user.getUserEmail1());
    }
}
