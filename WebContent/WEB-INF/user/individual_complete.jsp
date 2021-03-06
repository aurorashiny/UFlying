<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="zh_CN">
    <head>
        <title>完善信息</title>
        <meta charset="utf8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/3rdParty/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/users.css">
        <script type="text/javascript" name="interface">
        	model = {
    	    	    message: "${message}",
           			uid: "${form.uid}", 
           			name: "${form.name}", 
           			phone: "${form.phone}",
           			sex: ${form.sex},
           			email: "${form.email}",
           			qq:"${form.qq}",
           			address: "${form.address}",
           			province: "${form.province}",
           			city: "${form.city}",
           			status: ${form.status},
           			idCardNumber: "${form.idCardNumber}",
           			photoUrl: "${form.photoUrl}",
           			idCardUrl1: "${form.idCardUrl1}",
           			idCardUrl2: "${form.idCardUrl2}",
           			experience: ${form.experience}
        	};
            contextPath = '<%=request.getContextPath()%>';
        </script>

        <script type="text/javascript" src="<%=request.getContextPath()%>/3rdParty/jquery.js"></script>
	    <script type="text/javascript" src="<%=request.getContextPath()%>/3rdParty/underscore-min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/3rdParty/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/loader.js"></script>
    </head>
    <body class="moreInfo">
        <hgroup class="usersCommon boxWidth">
	        <a href="<%=request.getContextPath() %>/index.jsp"><img src="img/Logo.png" /></a>
            <button data-icon="LeftBlue" class="back"></button>
        </hgroup>
        <form action="<%=request.getContextPath()%>/individual_edit" method="post" enctype="multipart/form-data" novalidate>
            <input type="hidden" name="uid"/>                        
            <input type="hidden" name="phone"/>                        
            <input type="hidden" name="status"/>                        
            <section class="portal withHeader boxWidth">
                <header>
                    <div><img src="img/Right_DarkGray.png" alt="Next" /><span>基本信息</span></div>
                </header>
                <div class="staticInfo">
                    <section>
                        <label>会员ID：</label>
                        <span name="uid"></span>
                    </section>
                    <section>
                        <label>手机：</label>
                        <span name="phone"></span>
                    </section>
                </div>
            </section>
		    <section class="portal boxWidth alertBox">
		    	<div class="staticInfo alert" name="message">
		   		</div>
			</section>
            <section class="portal boxWidth form">
                <fieldset>
                    <section>
                        <strong>*</strong><input type="text" required data-prototype="name" placeholder="填写姓名" name="name"/>
                    </section>
                    <section class="horizon noFrameRow">
                        <strong>*</strong>
                        <input type="radio" name="sex" value="0" id="personal_female" />
                        <label for="personal_female">女</label>
                        <input type="radio" name="sex" value="1" id="personal_male" />
                        <label for="personal_male">男</label>
                        <input type="radio" name="sex" value="2" id="personal_secret" />
                        <label for="personal_secret">保密</label>
                    </section>
                    <section>
                        <strong>*</strong>
                        <input type="email" data-prototype="email" required placeholder="请填写Email地址" name="email"/>
                    </section>
                    <section class="horizon">
                        <strong>*</strong>
                        <select required="true" name="province" required data-prototype="province">
                            <option value="" disabled selected>省/直辖市/自治区</option>
                        </select>
                        <select required="true" name="city" disabled required data-prototype="city">
                            <option value="" disabled selected>城市</option>
                        </select>
                    </section>
                    <section>
                        <strong>*</strong>
                        <input type="text" required="true" placeholder="填写地址" data-prototype="address" name="address"/>
                    </section>
                    <section>
                        <strong></strong>
                        <input type="text" required="false" placeholder="填写QQ号" data-prototype="qq" name="qq"/>
                    </section>
                </fieldset>
            </section>
            <section class="portal boxWidth form collapseHeader">
                <fieldset>
                    <section class="noFrameRow" id="authenticateBox">
                        <strong></strong>
                        <input type="checkbox" id="toAuth" data-toggle="collapse" data-target=".form.collapse" aria-expanded="false"/> 
                        <label for="toAuth">申请成为认证会员</label>
                    </section>
                </fieldset>
            </section>
            <section class="portal boxWidth form collapse">
            	<fieldset>
                    <section>
                        <strong>*</strong><input type="text" required="true" class="extended" 
                        	required placeholder="填写身份证号码" data-prototype="idCardNumber"
                        	name="idCardNumber"/>
                    </section>
                    <section>
                        <strong>*</strong>
                        <input type="number" placeholder="飞行经验" msg-empty="请填写飞行经验" required="true" name="experience"  data-icon="Flight" min="0" step="10"/>
                        <label>小时</label>
                    </section>
                </fieldset>
            </section>
            <section class="portal boxWidth form fileInput collapse">
                <fieldset>
                    <small>上传为本人近期二寸免冠证件照（半年内），jpg格式，大小不超过2MB（高度在139像素至197像素之间；宽度在96像素至150像素之间）</small>
                    <section>
                        <strong>*</strong>
                        <p><a href="#" class="upload-btn" id="upload-photo-pic">
                            <input type="file" required msg-empty="请提交近照" accept="image/*" id="photo" name="photo" >
                            <img name="photoUrl"/>
                        </a></p>
                    </section>
                </fieldset>
            </section>
            <section class="portal boxWidth form fileInput collapse">
                <fieldset>
                    <div><small>上传本人身份证原件正面、反面照片各一张，jpg格式，确保图片（证件底纹、文字、人物照片）清晰，无模糊，无高光白等；照片大小为100KB以上，10MB以内（建议使用800W像素以上相机拍摄）；确保证件边角显示完整</small></div>
                    <section>
                        <strong>*</strong>
                        <p><a href="javascript:;" class="upload-btn" id="upload-photo-id-front">
                            <input type="file" required="required" msg-empty="请提交身份证正面照片" accept="image/*" id="idFront" name="identity_front" >
	                        <img name="idCardUrl1"/>
                        </a></p>
                    </section>
                    <section>
                        <strong>*</strong>
                        <p><a href="javascript:;" class="upload-btn" id="upload-photo-id-back">
                            <input type="file" required="required" msg-empty="请提交身份证反面照片" accept="image/*" id="idBack" name="identity_back" >
	                        <img name="idCardUrl2"/>
                        </a></p>
                    </section>
                </fieldset>
            </section>
            <section class="portal boxWidth form collapse" data-name="contract">
                <fieldset>
                    <section class="noFrameRow">
                        <strong></strong>
                        <input type="checkbox" id="toContract">
                        <label>已阅读并同意<a href="<%=request.getContextPath()%>/js/contract.html">商签会员注册协议</a>，申请成为商签会员</label>
                    </section>
                </fieldset>
            </section>
            <footer class="portal boxWidth form">
                <fieldset>
                    <section>
                        <strong></strong><input type="submit" value="提 交"/>
                    </section>
                </fieldset>
            </footer>
        </form>
    </body>
    <script type="text/javascript">
        $("input[type=file]").on("change", function(evt) {
            var img = $(this).siblings("img").attr("src", "");
            var file = evt.target.files[0];
            if (!file.type.match('image.*')) {
                return false;
            }

            var reader = new FileReader();
            reader.onload = (function(file) {
                return function(e) {
                    $(img).attr('src', e.target.result);
                };
            })(file);
            reader.readAsDataURL(file);
        });
</script>
    
</html>
