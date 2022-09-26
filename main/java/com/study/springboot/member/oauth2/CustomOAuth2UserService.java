package com.study.springboot.member.oauth2;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.study.springboot.member.service.SnsService;

@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
	@Autowired
	SnsService service;

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		OAuth2UserService delegate = new DefaultOAuth2UserService();
		OAuth2User oAuth2User = delegate.loadUser(userRequest);

		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		String userNameAttributeName = userRequest.getClientRegistration()
				                                  .getProviderDetails()
				                                  .getUserInfoEndpoint()
				                                  .getUserNameAttributeName();

		OAuthAttributes attributes = OAuthAttributes.of(registrationId,
				                                        userNameAttributeName,
				                                        oAuth2User.getAttributes());
		
		service.snsLogin(registrationId, attributes.getId(), attributes.getName(), attributes.getEmail());
//		System.out.println("Picture:"+attributes.getPicture());

		return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority("role_user")),
				                     attributes.getAttributes(),
				                     attributes.getNameAttributeKey());
	}
}