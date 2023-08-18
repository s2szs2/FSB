package com.ezen.FSB;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class KakaoController {

	  private final static String K_CLIENT_ID = "c4d7636880ff1b6ee5fe5baee7289e7b"; //카카오개발자 아이디
      //이런식으로 REDIRECT_URI를 써넣는다.                                                                                                  //                                                //
	  private final static String K_REDIRECT_URI = "http://localhost:8081/FSB/kakao.do"; //카카오개발자 uri

	  
	  public static String getAuthorizationUrl(HttpSession session) {
		  String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?" + "client_id=" + K_CLIENT_ID + "&redirect_uri="
				  + K_REDIRECT_URI + "&response_type=code";
		  return kakaoUrl;
	  }


	  public static JsonNode getAccessToken(String autorize_code) { //토큰 받아오기
		  final String RequestUrl = "https://kauth.kakao.com/oauth/token";
		  final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
		  postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
		  postParams.add(new BasicNameValuePair("client_id", "c4d7636880ff1b6ee5fe5baee7289e7b")); // REST API KEY
		  postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8081/FSB/kakao.do")); // 리다이렉트 URI                                                              
		  postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정중 얻은 code 값
		  final HttpClient client = HttpClientBuilder.create().build();
		  final HttpPost post = new HttpPost(RequestUrl);
		  JsonNode returnNode = null;
		  try {
			  post.setEntity(new UrlEncodedFormEntity(postParams));
			  final HttpResponse response = client.execute(post);
			  // JSON 형태 반환값 처리
			  ObjectMapper mapper = new ObjectMapper();
			  returnNode = mapper.readTree(response.getEntity().getContent());
		  } catch (UnsupportedEncodingException e) {
			  e.printStackTrace();
		  } catch (ClientProtocolException e) {
			  e.printStackTrace();
		  } catch (IOException e) {
			  e.printStackTrace();
		  } finally {
			  // 	clear resources
		  }
		  return returnNode;
	  }

	  public static JsonNode getKakaoUserInfo(JsonNode accessToken) { //카카오 정보 받아오기 
		  final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
		  final HttpClient client = HttpClientBuilder.create().build();
		  final HttpPost post = new HttpPost(RequestUrl);
		  // add header
		  post.addHeader("Authorization", "Bearer " + accessToken);
		  JsonNode returnNode = null;
		  try {
			  final HttpResponse response = client.execute(post);
			  // JSON 형태 반환값 처리
			  ObjectMapper mapper = new ObjectMapper();
			  returnNode = mapper.readTree(response.getEntity().getContent());
		  } catch (ClientProtocolException e) {
			  e.printStackTrace();
		  } catch (IOException e) {
			  e.printStackTrace();
		  } finally {
			  // clear resources
		  }
		  return returnNode;
	  }
	  
	  public static void kakaoLogout(String access_Token) { //카카오톡 로그아웃 
		    String reqURL = "https://kapi.kakao.com/v1/user/logout";
		    try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
		        
		        int responseCode = conn.getResponseCode();
		        System.out.println("responseCode : " + responseCode);
		        
		        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        
		        String result = "";
		        String line = "";
		        
		        while ((line = br.readLine()) != null) {
		            result += line;
		        }
		        System.out.println(result);
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		}
	  
		public static void unlink(String access_Token) { //연결끊기? 회원탈퇴
		    String reqURL = "https://kapi.kakao.com/v1/user/unlink";
		    try {
		        URL url = new URL(reqURL);
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
		        
		        int responseCode = conn.getResponseCode();
		        System.out.println("responseCode : " + responseCode);
		        
		        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        
		        String result = "";
		        String line = "";
		        
		        while ((line = br.readLine()) != null) {
		            result += line;
		        }
		        System.out.println(result);
		    } catch (IOException e) {
		        e.printStackTrace();
		    }
		}
}
