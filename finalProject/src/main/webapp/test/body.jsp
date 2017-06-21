<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
   String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko"><head>
   <meta charset="utf-8">
   <title> 배달의민족 :: 대한민국 1등 배달앱</title>
   <style type="text/css">

#gesipan table, #gesipan td, #gesipan a {
	background-color: white;
}
#gesipan table {
	margin: 23.5px 44.75px;
	border: 4px solid gray;
	outline: 2px solid black;
}
/*!
 * www.baemin.com
 * Copyright 2013 Woowa Brothers Corp.
 */ /*!
 * Bootstrap v3.0.0
 *
 * Copyright 2013 Twitter, Inc
 * Licensed under the Apache License v2.0
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Designed and built with all the love in the world by @mdo and @fat.
 */
*, *:before, *:after {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box
}

.list-inline {
	padding-left: 0;
	list-style: none
}

.container {
	margin-right: auto;
	margin-left: auto;
	padding-left: 10px;
	padding-right: 10px
}

.container:before, .container:after {
	content: " ";
	display: table
}

.container:after {
	clear: both
}

.container:before, .container:after {
	content: " ";
	display: table
}

.container:after {
	clear: both
}

.row {
	margin-left: -10px;
	margin-right: -10px
}

.row:before, .row:after {
	content: " ";
	display: table
}

.row:after {
	clear: both
}

.row:before, .row:after {
	content: " ";
	display: table
}

.row:after {
	clear: both
}

.col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6,
	.col-xs-7, .col-xs-8, .col-xs-9, .col-xs-10, .col-xs-11, .col-xs-12,
	.col-sm-1, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6,
	.col-sm-7, .col-sm-8, .col-sm-9, .col-sm-10, .col-sm-11, .col-sm-12,
	.col-md-1, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6,
	.col-md-7, .col-md-8, .col-md-9, .col-md-10, .col-md-11, .col-md-12,
	.col-lg-1, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6,
	.col-lg-7, .col-lg-8, .col-lg-9, .col-lg-10, .col-lg-11, .col-lg-12 {
	position: relative;
	min-height: 1px;
	padding-left: 10px;
	padding-right: 10px
}

.col-xs-1, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6,
	.col-xs-7, .col-xs-8, .col-xs-9, .col-xs-10, .col-xs-11 {
	float: left
}

.col-xs-1 {
	width: 8.33333333%
}

.col-xs-2 {
	width: 16.66666667%
}

.col-xs-3 {
	width: 25%
}

.col-xs-4 {
	width: 33.33333333%
}

.col-xs-5 {
	width: 41.66666667%
}

.col-xs-6 {
	width: 50%
}

.col-xs-7 {
	width: 58.33333333%
}

.col-xs-8 {
	width: 66.66666667%
}

.col-xs-9 {
	width: 75%
}

.col-xs-10 {
	width: 83.33333333%
}

.col-xs-11 {
	width: 91.66666667%
}

.col-xs-12 {
	width: 100%
}

@media ( min-width :982px) {
	.container {
		max-width: 980px
	}
}

.boxm {
	position: relative;
	padding: 20px;
	font-size: 11px;
	line-height: 1.4em
}

.boxm.col1 {
	width: 240px
}

.boxm.col2 {
	width: 480px
}

.boxm.col2 .default {
	overflow: hidden;
	width: 440px;
	height: 440px;
	background-size: 100% 100%;
	-webkit-background-size: 100% 100%;
	-moz-border-radius: 100%;
	-webkit-border-radius: 100%;
	border-radius: 100%;
	behavior: url(http://www.baemin.com/css/main/PIE.htc)
}

.cutter {
	width: 100%;
	height: 100%;
	background-repeat: no-repeat;
	background-position: center center;
	background-size: 100% 100%;
	text-indent: -9999px
}

/*중앙 작은메뉴 크기정하기*/
.cutter .cover, .cutter .default {
	width: 200px;
	height: 200px;
	background-repeat: no-repeat
}

.cutter .caroufredsel_wrapper {
	margin: 0 !important
}

/*중앙 커버이미지 크기및 위치*/
.cutter .cover {
	position: absolute;
	-moz-border-radius: 100%;
	-webkit-border-radius: 100%;
	border-radius: 100%;
	behavior: url(http://www.baemin.com/css/main/PIE.htc);
}

.cutter .default {
	position: relative;
	background-position: center center
}

.cutter .btn-control a, .pager {
	position: absolute;
	z-index: 200;
}

/*치킨 디폴트*/
.cutter.chicken .default:hover {
	background-image: url(../resource/img/chicken.gif);
}

@media only screen and (min-resolution:2dppx) {
	.cutter.chicken .cover {
		border-radius: 50%;
		background-image: url("../resource/img/chicken.jpg");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.chicken .default {
		border-radius: 50%;
		background-image: url("../resource/img/chicken.jpg");
		background-size: 200px 200px;
	}
}

.cutter.chicken .default {
	border-radius: 50%;
	background-image: url("../resource/img/chicken.jpg");
	background-size: 200px 200px;
}

/*중국집 디폴트*/
.cutter.chinese .default:hover {
	background-image: url(../resource/img/china.gif);
}

@media only screen and (min-resolution:2dppx) {
	.cutter.chinese .cover {
		border-radius: 50%;
		background-image: url("../resource/img/china.jpg");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.chinese .default {
		border-radius: 50%;
		background-image: url("../resource/img/china.jpg");
		background-size: 200px 200px;
	}
}

.cutter.chinese .default {
	border-radius: 50%;
	background-image: url("../resource/img/china.jpg");
	background-size: 200px 200px;
}

/*피자 디폴트*/
.cutter.pizza .default:hover {
	background-image: url(../resource/img/pizza.gif);
}

@media only screen and (min-resolution:2dppx) {
	.cutter.pizza .cover {
		border-radius: 50%;
		background-image: url("../resource/img/pizza.jpg");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.pizza .default {
		border-radius: 50%;
		background-image: url("../resource/img/pizza.jpg");
		background-size: 200px 200px;
	}
}

.cutter.pizza .default {
	border-radius: 50%;
	background-image: url("../resource/img/pizza.jpg");
	background-size: 200px 200px;
}

/*분식 디폴트*/
.cutter.korean .default:hover {
	background-image: url("../resource/img/bunsic.gif")
}

@media only screen and (min-resolution:2dppx) {
	.cutter.korean .cover {
		border-radius: 50%;
		background-image: url("../resource/img/bunsic.jpg");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.korean .default {
		border-radius: 50%;
		background-image: url("../resource/img/bunsic.jpg");
		background-size: 200px 200px;
	}
}

.cutter.korean .default {
	border-radius: 50%;
	background-image: url("../resource/img/bunsic.jpg");
	background-size: 200px 200px;
}

/*족발 디폴트*/
.cutter.jokbal .default:hover {
	background-image: url("../resource/img/bossam.gif")
}

@media only screen and (min-resolution:2dppx) {
	.cutter.jokbal .cover {
		border-radius: 50%;
		background-image: url("../resource/img/bossam.png");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.jokbal .default {
		border-radius: 50%;
		background-image: url("../resource/img/bossam.png");
		background-size: 200px 200px;
	}
}

.cutter.jokbal .default {
	border-radius: 50%;
	background-image: url("../resource/img/bossam.png");
	background-size: 200px 200px;
}

/*야식 디폴트*/
.cutter.night .default:hover {
	background-image: url("../resource/img/ya.gif");
}

@media only screen and (min-resolution:2dppx) {
	.cutter.night .cover {
		border-radius: 50%;
		background-image: url("../resource/img/ya.jpg");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.night .default {
		border-radius: 50%;
		background-image: url("../resource/img/ya.jpg");
		background-size: 200px 200px;
	}
}

.cutter.night .default {
	border-radius: 50%;
	background-image: url("../resource/img/ya.jpg");
	background-size: 200px 200px;
}

/*찜 탕*/
.cutter.tang .default:hover {
	background-image: url("../resource/img/zzim.gif")
}

@media only screen and (min-resolution:2dppx) {
	.cutter.tang .cover {
		border-radius: 50%;
		background-image: url("../resource/img/zzim.jpg");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.tang .default {
		border-radius: 50%;
		background-image: url("../resource/img/zzim.jpg");
		background-size: 200px 200px;
	}
}

.cutter.tang .default {
	border-radius: 50%;
	background-image: url("../resource/img/zzim.jpg");
	background-size: 200px 200px;
}

/*일식*/
.cutter.japanese .default:hover {
	background-image: url("../resource/img/don.gif")
}

@media only screen and (min-resolution:2dppx) {
	.cutter.japanese .cover {
		border-radius: 50%;
		background-image: url("../resource/img/don.jpg");
		width: 200px; height: auto;
		background-size: 200px 200px;
	}
	.cutter.japanese .default {
		border-radius: 50%;
		background-image: url("../resource/img/don.jpg");
		background-size: 200px 200px;
	}
}

.cutter.japanese .default {
	border-radius: 50%;
	background-image: url("../resource/img/don.jpg");
	background-size: 200px 200px;
}

.cutter.theme1 .cover {
	background-image: url(https://img.woowahan.com/www/main/cate11-over.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.theme1 .cover {
		background-image: url(https://img.woowahan.com/www/main/cate11-over.png);
		background-size: 130px 130px
	}
	.cutter.theme1 .default {
		background-image: url(https://img.woowahan.com/www/main/cate11.png);
		background-size: 130px 130px
	}
}

.cutter.theme1 .default {
	background-image: url(https://img.woowahan.com/www/main/cate11.png)
}

.cutter.theme2 .cover {
	background-image: url(https://img.woowahan.com/www/main/cate12-over.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.theme2 .cover {
		background-image: url(https://img.woowahan.com/www/main/cate12-over.png);
		background-size: 130px 130px
	}
	.cutter.theme2 .default {
		background-image: url(https://img.woowahan.com/www/main/cate12.png);
		background-size: 130px 130px
	}
}

.cutter.theme2 .default {
	background-image: url(https://img.woowahan.com/www/main/cate12.png)
}

.cutter.theme3 .cover {
	background-image: url(https://img.woowahan.com/www/main/cate13-over.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.theme3 .cover {
		background-image: url(https://img.woowahan.com/www/main/cate13-over.png);
		background-size: 130px 130px
	}
	.cutter.theme3 .default {
		background-image: url(https://img.woowahan.com/www/main/cate13.png);
		background-size: 130px 130px
	}
}

.cutter.theme3 .default {
	background-image: url(https://img.woowahan.com/www/main/cate13.png)
}

.cutter.theme4 .cover {
	background-image: url(https://img.woowahan.com/www/main/cate14-over.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.theme4 .cover {
		background-image: url(https://img.woowahan.com/www/main/cate14-over.png);
		background-size: 130px 130px
	}
	.cutter.theme4 .default {
		background-image: url(https://img.woowahan.com/www/main/cate14.png);
		background-size: 130px 130px
	}
}

.cutter.theme4 .default {
	background-image: url(https://img.woowahan.com/www/main/cate14.png)
}

.cutter.theme5 .cover {
	background-image: url(https://img.woowahan.com/www/main/cate15-over.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.theme5 .cover {
		background-image: url(https://img.woowahan.com/www/main/cate15-over.png);
		background-size: 130px 130px
	}
	.cutter.theme5 .default {
		background-image: url(https://img.woowahan.com/www/main/cate15.png);
		background-size: 130px 130px
	}
}

.cutter.theme5 .default {
	background-image: url(https://img.woowahan.com/www/main/cate15.png)
}

.cutter.baro .default {
	background-image: url(https://img.woowahan.com/www/main/baro.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.baro .default {
		background-image: url(https://img.woowahan.com/www/main/baro.png);
		background-size: 130px 130px
	}
	.cutter.summer .cover {
		background-image: url(https://img.woowahan.com/www/main/cate16-over.png);
		background-size: 130px 130px
	}
}

.cutter.summer .cover {
	background-image: url(https://img.woowahan.com/www/main/cate16-over.png)
}

.cutter.summer .default {
	background-image: url(https://img.woowahan.com/www/main/cate16.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.summer .default {
		background-image: url(https://img.woowahan.com/www/main/cate16.png);
		background-size: 130px 130px
	}
	.cutter.nothing .default {
		background-image: url(https://img.woowahan.com/www/main/nothing.png);
		background-size: 130px 130px
	}
}

.cutter.nothing .default {
	background-image: url(https://img.woowahan.com/www/main/nothing.png)
}

.cutter.promo {
	text-indent: 0 !important
}

.cutter.promo .default ul {
	opacity: 1 !important
}

.cutter.promo .default li {
	float: left;
	width: 440px;
	height: 440px;
	padding: 0;
	background-size: 440px 440px
}

.cutter.promo .default li.promo_bangga_201508001 {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_bangga_201508001.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_bangga_201508001 {
		background-image:
			url(https://img.woowahan.com/www/temp/promo_bangga_201508001@2.png);
		background-size: 290px 290px
	}
}

.cutter.promo .default li.promo_surprise {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_surprise.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_surprise {
		background-image:
			url(https://img.woowahan.com/www/temp/promo_surprise@2.png);
		background-size: 290px 290px
	}
}

.cutter.promo .default li.promo_urgent {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_urgent.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_urgent {
		background-image:
			url(https://img.woowahan.com/www/temp/promo_urgent@2.png);
		background-size: 290px 290px
	}
}

.cutter.promo .default li.promo_deliverygod_main02 {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_deliverygod_main02.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_deliverygod_main02 {
		background-image:
			url(https://img.woowahan.com/www/temp/promo_deliverygod_main02@2.png);
		background-size: 290px 290px
	}
}

.cutter.promo .default li.promo_bangga2_july {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_bangga2_july.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_bangga2_july {
		background-image:
			url(https://img.woowahan.com/www/temp/promo_bangga2_july@2.png);
		background-size: 290px 290px
	}
}

.cutter.promo .default li.promo_tmember {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_tmember.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_tmember {
		background-image:
			url(https://img.woowahan.com/www/temp/promo_tmember@2.png);
		background-size: 290px 290px
	}
}

.cutter.promo .default li.promo_bangga2_1506 {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_bangga2_1506.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_bangga2_1506 {
		background-image:
			url("../resource/img/chiken.jpg");
		background-size: 290px 290px
	}
}

.cutter.promo .default li.promo_couponset {
	background-image:
		url(https://img.woowahan.com/www/temp/promo_couponset.png)
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , only screen and
		(min--moz-device-pixel-ratio:2) , only screen and
		(-o-min-device-pixel-ratio:2/1) , only screen and
		(min-device-pixel-ratio:2) , only screen and (min-resolution:192dpi) ,
		only screen and (min-resolution:2dppx) {
	.cutter.promo .default li.promo_couponset {
		background-image:
			url(https://img.woowahan.com/www/temp/promo_couponset@2.png);
		background-size: 290px 290px
	}
}

.cutter.promo .default li a {
	float: left;
	width: 440px;
	height: 440px;
	font-size: 0
}

.cutter.game .default {
	background-image: url(https://img.woowahan.com/www/main/game1.png)
}

.cutter.game .default.mobile {
	background-image: url(https://img.woowahan.com/www/main/game2.png)
}

.cutter .btn-control a, .pager a {
	display: inline-block;
	background-image:
		url(https://img.woowahan.com/www/main/carou-controls.png);
	background-repeat: no-repeat
}

.cutter .btn-control a {
	top: 50%;
	width: 30px;
	height: 47px;
	margin-top: -25px;
	text-indent: -9999px
}

.cutter .btn-control a.prev {
	left: 20px;
	background-position: -100px 0
}

.cutter .btn-control a.next {
	right: 20px;
	background-position: -150px 0
}

.pager {
	left: 50%;
	bottom: 30px;
	width: 440px;
	margin-left: -220px
}

.pager a {
	width: 14px;
	height: 14px;
	margin: 0 5px;
	background-position: -50px 0
}

.pager a.selected {
	background-position: 0 0
}

.pager a span {
	display: block;
	text-indent: -9999px
}

@media only screen and (-webkit-min-device-pixel-ratio:2) , screen and
	(max-width:320px) {
	.boxm {
		padding: 15px
	}
	.boxm.col1 {
		width: 160px
	}
	.boxm.col2 {
		width: 320px
	}
	.boxm.col2 .default {
		width: 290px !important;
		height: 290px !important
	}
	.boxm.col2 .default li {
		width: 290px;
		height: 290px;
		border-radius: 100%
	}
	.boxm .cutter .cover {
		display: none
	}
	.boxm .cutter .default {
		width: 130px;
		height: 130px
	}
	.boxm .cutter.promo .default ul {
		height: 290px
	}
	.boxm .cutter.promo .default li {
		width: 290px;
		height: 290px;
		background-size: 290px 290px
	}
	.boxm .cutter.promo .default li a {
		width: 290px;
		height: 290px
	}
	.boxm .cutter .btn-control a {
		top: 55%;
		width: 17px;
		height: 26px;
		background-size: 100px 25px;
		-webkit-background-size: 100px 25px
	}
	.boxm .cutter .btn-control a.prev {
		left: 10px;
		background-position: -50px 0
	}
	.boxm .cutter .btn-control a.next {
		right: 10px;
		background-position: -75px 0
	}
	.boxm .cutter .pager {
		width: 300px;
		bottom: 10px;
		margin-left: -150px
	}
	.boxm .cutter .pager a {
		width: 8.5px;
		height: 9px;
		margin: 0 3px;
		background-size: 100px 25px;
		-webkit-background-size: 100px 25px;
		background-position: -25px -17px
	}
	.boxm .cutter .pager a.selected {
		background-position: 0 -17px
	}
}
</style>
   

   <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   <script src="jquery.min.js"></script>
   <script src="jquery.masonry.min.js"></script>
      
      </head>
      
<body>




   
   <input type="hidden" name="CurClass" id="CurClass" value="">
   <input type="hidden" name="kw" id="kw" value="">
   <div class="container of-h">
      <div class="cont" style="position: relative; height: 2400px; width: 480px;">
         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('치킨');" style="position: absolute; top: 0px; left: 0px;">
            <div class="cutter chicken">
               <div class="default">치킨</div>
               <div class="cover" style="background-position: 0px 0px;"></div>
            </div>
         </div>

         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('중국집');" style="position: absolute; top: 0px; left: 240px;">
            <div class="cutter chinese">
               <div class="cover" style="background-position: 0px 0px;"></div>
               <div class="default">중국집</div>
            </div>
         </div>

         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('피자');" style="position: absolute; top: 240px; left: 0px;">
            <div class="cutter pizza">
               <div class="cover" style="background-position: 0px 0px;"></div>
               <div class="default">피자</div>
            </div>
         </div>

         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('한식,분식');" style="position: absolute; top: 240px; left: 240px;">
            <div class="cutter korean">
               <div class="cover" style="background-position: 0px 0px;"></div>
               <div class="default">한식,분식</div>
            </div>
         </div>

         <div class="boxm col2 masonry-brick" style="position: absolute; top: 0px; left: 0px;">
            <div class="cutter promo">
               <div class="default">
                  <div class="caroufredsel_wrapper" style="display: block; text-align: center; float: none; position: relative; top: auto; right: auto; bottom: auto; left: auto; z-index: auto; width: 440px; height: 440px; margin: 0px 0px 10px; overflow: hidden;">
                  <ul id="promotion" class="list-inline" style="text-align: left; float: none; position: absolute; top: 0px; right: auto; bottom: auto; left: 0px; margin: 0px; width: 1320px; height: 440px;">
                                <li style="background-image: url('../resource/img/banner02.gif')"><a>최대 6천원 할인</a></li>
                  </ul></div>
                  <div class="btn-control">
                     <a href="javascript:;" class="prev prev3 hidden" style="display: none;">&lt;</a>
                     <a href="javascript:;" class="next next3 hidden" style="display: none;">&gt;</a>
                  </div>
                  <div id="pager" class="pager hidden" style="display: none;"><a href="#" class="selected"><span>1</span></a></div>
               </div>
            </div>
         </div>
         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('족발,보쌈');" style="position: absolute; top: 960px; left: 0px;">
            <div class="cutter jokbal">
               <div class="cover" style="background-position: 0px 0px;"></div>
               <div class="default" >족발,보쌈</div>
            </div>
         </div>

         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('야식');" style="position: absolute; top: 960px; left: 240px;">
            <div class="cutter night">
               <div class="cover" style="background-position: 0px 0px;"></div>
               <div class="default">야식</div>
            </div>
         </div>

         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('찜,탕');" style="position: absolute; top: 1200px; left: 0px;">
            <div class="cutter tang">
               <div class="cover" style="background-position: 0px 0px;"></div>
               <div class="default">찜,탕</div>
            </div>
         </div>

         <div class="boxm col1 masonry-brick" onclick="fn_sch_kw('돈까스,회,일식');" style="position: absolute; top: 1200px; left: 240px;">
            <div class="cutter japanese">
               <div class="cover" style="background-position: 0px 0px;"></div>
               <div class="default">돈까스,회,일식</div>
            </div>
         </div>
   </div> <!--/.cont -->
</div>

<div style="width: 979px; height: 400px; margin: 0 auto 30px;" id="gesipan">
	<table style="width: 400px; height: 153px; float: left;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				공지사항
			</td>
		</tr>
		<tr>
			<td style="font-weight: bold;">
				[공지] 멤버쉽 등급 및 혜택 안내
			</td>
			<td>
				2017-06-19
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				안녕하세요. 사이트이름입니다. 현재 시행중인 회원제 선정기준 및 혜택 에 대해 안내 드립니다.
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>


	<table style="width: 400px; height: 153px; float: right;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				맛집리뷰 게시판
			</td>
		</tr>
		<tr>
			<td style="font-weight: bold;">
				내닉네임 | 맛있어요♡
			</td>
			<td>
				2017-06-05
			</td>
		</tr>
		<tr>
			<td style="font-size: 13px;">
				치킨이 친절하고 사장님이 맛있습니다!<br>                
			</td>
			<td align="right">
				★★★★☆
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>
	<table style="width: 400px; height: 153px; float: left;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				이벤트
			</td>
		</tr>
		<tr>
			<td style="font-weight: bold;">
				[이벤트] 오늘 하루 치킨이 반값!
			</td>
			<td>
				2017-06-21
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				안녕하세요. 사이트이름입니다. 오늘은 치킨의 날로써 모든 치킨이 반값이오니 많은 주문 바랍니다.
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>


	<table style="width: 400px; height: 153px; float: right;">
		<tr>
			<td colspan="2" style="font-weight: bold; font-size: 20px;" align="center">
				F A Q
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-weight: bold;">
				내닉네임 | [질문] 아이디를 잊어버렸습니다.
			</td>
		</tr>
		<tr>
			<td colspan="2" style="font-size: 13px;">
				[답변] 앞으로 우리 싸이트 이용하지 마요.                
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<a style="font-size: 10px; cursor: pointer;">더보기</a>
			</td>
		</tr>
	</table>
</div>



<script type="text/javascript">   

//------------------------------------------------------------------------------
//PURPOSE : 메인하단 스크립트
//MODIFY  :
//------------------------------------------------------------------------------
var $container = $('.cont');
$container.imagesLoaded( function() {
  $container.masonry({
    itemSelector: '.boxm',
    isAnimated: true,
    isFitWidth: true
  });
});



</script>





</body></html>