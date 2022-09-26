package com.study.springboot.member.dto;

import lombok.Data;

import javax.validation.constraints.*;

@Data
public class ValidationMember {

    @Size(min=4,max=10,message = "아이디는 4~10자리만 가능합니다.")
    @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "아이디는 영문 대/소문자와 숫자만 사용가능합니다.")
    @NotNull(message = "아이디는 비워둘 수 없습니다")
    private String id;
    @NotBlank(message = "비밀번호는 비워둘 수 없습니다.")
    @Pattern(regexp = "^.*(?=^.{8,16}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$", message = "비밀번호는 숫자,영문,특수문자(!@#$%^&+=)를 포함한 8~16자리여야합니다. ")
    private String pw;
    @Size(min=2,message = "이름은 최소 2자리여야 합니다.")
    @Pattern(regexp = "^[가-힣]*$", message = "이름은 한글만 사용가능합니다.")
    @NotNull(message = "이름은 비워둘 수 없습니다.")
    private String name;
    @NotNull(message = "이메일은 비워둘 수 없습니다.")
    @NotEmpty(message = "이메일은 비워둘 수 없습니다.")
    @Pattern(regexp = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$", message = "이메일 형식에 맞지않습니다.")
    private String firstEmail;
    @NotNull(message = "이메일은 비워둘 수 없습니다.")
    @NotEmpty(message = "이메일은 비워둘 수 없습니다.")
    @Pattern(regexp = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$", message = "이메일 형식에 맞지않습니다.")
    private String secondEmail;
    @Pattern(regexp = "^[0-9]*$", message = "전화번호는 숫자만 가능합니다.")
    private String bcm_phonenum1;
    @Pattern(regexp = "^[0-9]*$", message = "전화번호는 숫자만 가능합니다.")
    private String bcm_phonenum2;
    @Pattern(regexp = "^[0-9]*$", message = "전화번호는 숫자만 가능합니다.")
    private String bcm_phonenum3;
    @Pattern(regexp = "^[0-9]*$", message = "우편번호는 숫자만 가능합니다")
    private String bcm_zipcode;
    private String bcm_address1;
    private String bcm_address2;
    private String bcm_address3;

}
