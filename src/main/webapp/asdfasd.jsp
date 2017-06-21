<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />


<meta charset="utf-8" />
<title>finalp</title>
<meta name="fb_admins_meta_tag" content="" />
<link rel="shortcut icon" href="https://www.wix.com/favicon.ico"
	type="image/x-icon" />
<link rel="apple-touch-icon" href="https://www.wix.com/favicon.ico"
	type="image/x-icon" />
<script type="text/javascript">
	var santaBase = 'https://static.parastorage.com/services/santa/1.2326.9';
	var clientSideRender = true;
</script>

<script defer
	src="https://static.parastorage.com/services/third-party/requirejs/2.1.15/require.min.js"></script>
<script defer
	src="https://static.parastorage.com/services/santa/1.2326.9/app/main-r.min.js"></script>


<link rel="prefetch"
	href="https://static.parastorage.com/services/third-party/react/0.14.3/react-with-addons.min.js">
<link rel="prefetch"
	href="https://static.parastorage.com/services/third-party/tweenmax/1.19.0/minified/TweenMax.min.js">
<link rel="prefetch"
	href="https://static.parastorage.com/services/third-party/lodash/4.17.4/dist/lodash.min.js">

<link rel="preconnect" href="https://static.wixstatic.com/">
<link rel="preconnect" href="//fonts.googleapis.com">
<meta http-equiv="X-Wix-Renderer-Server" content="app204.vac.aws" />
<meta http-equiv="X-Wix-Meta-Site-Id"
	content="fc72b024-c09e-4ae0-8a9d-a518935949f8" />
<meta http-equiv="X-Wix-Application-Instance-Id"
	content="65dc45d2-5183-402c-895a-2002b60c0f51" />
<meta http-equiv="X-Wix-Published-Version" content="9" />

<meta http-equiv="etag" content="8545f15f1019d6e5a86161f54af3d172" />
<meta property="og:title" content="finalp" />
<meta property="og:type" content="article" />
<meta property="og:url"
	content="https://djswprkwlsk1.wixsite.com/finalp" />
<meta property="og:site_name" content="finalp" />
<meta name="SKYPE_TOOLBAR" content="SKYPE_TOOLBAR_PARSER_COMPATIBLE" />

<meta id="wixMobileViewport" name="viewport"
	content="width=980, user-scalable=yes" />





<script>
	// BEAT MESSAGE
	try {
		window.wixBiSession = {
			initialTimestamp : Date.now(),
			viewerSessionId : 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(
					/[xy]/g, function(c) {
						var r = Math.random() * 16 | 0, v = c == 'x' ? r
								: (r & 0x3 | 0x8);
						return v.toString(16);
					})
		};
		(new Image()).src = 'https://frog.wix.com/bt?src=29&evid=3&pn=1&et=1&v=1.2326.9&msid=fc72b024-c09e-4ae0-8a9d-a518935949f8&vsi='
				+ wixBiSession.viewerSessionId
				+ '&url='
				+ encodeURIComponent(location.href.replace(
						/^http(s)?:\/\/(www\.)?/, ''))
				+ '&isp=0&st=2&ts=0&c='
				+ wixBiSession.initialTimestamp;
	} catch (e) {
	}
	// BEAT MESSAGE END
</script>



<!-- META DATA -->
<script type="text/javascript">
	var serviceTopology = {
		"serverName" : "app204.vac.aws",
		"cacheKillerVersion" : "1",
		"staticServerUrl" : "https://static.parastorage.com/",
		"usersScriptsRoot" : "https://static.parastorage.com/services/wix-users/2.660.0",
		"biServerUrl" : "https://frog.wix.com/",
		"userServerUrl" : "https://users.wix.com/",
		"billingServerUrl" : "https://premium.wix.com/",
		"mediaRootUrl" : "https://static.wixstatic.com/",
		"logServerUrl" : "https://frog.wix.com/plebs",
		"monitoringServerUrl" : "https://TODO/",
		"usersClientApiUrl" : "https://users.wix.com/wix-users",
		"publicStaticBaseUri" : "https://static.parastorage.com/services/wix-public/1.231.0",
		"basePublicUrl" : "https://www.wix.com/",
		"postLoginUrl" : "https://www.wix.com/my-account",
		"postSignUpUrl" : "https://www.wix.com/new/account",
		"baseDomain" : "wix.com",
		"staticMediaUrl" : "https://static.wixstatic.com/media",
		"staticAudioUrl" : "https://music.wixstatic.com/mp3",
		"staticDocsUrl" : "https://docs.wixstatic.com/ugd",
		"emailServer" : "https://assets.wix.com/common-services/notification/invoke",
		"blobUrl" : "https://static.parastorage.com/wix_blob",
		"htmlEditorUrl" : "http://editor.wix.com/html",
		"siteMembersUrl" : "https://users.wix.com/wix-sm",
		"scriptsLocationMap" : {
			"santa-versions" : "https://static.parastorage.com/services/santa-versions/1.419.0",
			"dbsm-viewer-app" : "https://static.parastorage.com/services/dbsm-viewer-app/1.86.0",
			"wix-music-embed" : "https://static.parastorage.com/services/wix-music-embed/1.26.0",
			"santa-resources" : "https://static.parastorage.com/services/santa-resources/1.2.0",
			"wixapps" : "https://static.parastorage.com/services/wixapps/2.486.0",
			"ecommerce" : "https://static.parastorage.com/services/ecommerce/1.203.0",
			"dbsm-editor-app" : "https://static.parastorage.com/services/dbsm-editor-app/1.246.0",
			"langs" : "https://static.parastorage.com/services/langs/2.568.0",
			"automation" : "https://static.parastorage.com/services/automation/1.23.0",
			"web" : "https://static.parastorage.com/services/web/2.1229.63",
			"sitemembers" : "https://static.parastorage.com/services/sm-js-sdk/1.31.0",
			"js-wixcode-sdk" : "https://static.parastorage.com/services/js-wixcode-sdk/1.138.0",
			"tpa" : "https://static.parastorage.com/services/tpa/2.1062.0",
			"santa" : "https://static.parastorage.com/services/santa/1.2326.9",
			"skins" : "https://static.parastorage.com/services/skins/2.1229.63",
			"core" : "https://static.parastorage.com/services/core/2.1229.63",
			"santa-members-viewer-app" : "https://static.parastorage.com/services/santa-members-viewer-app/1.4.0",
			"ck-editor" : "https://static.parastorage.com/services/ck-editor/1.87.3",
			"bootstrap" : "https://static.parastorage.com/services/bootstrap/2.1229.63",
			"santa-members-editor-app" : "https://static.parastorage.com/services/santa-members-editor-app/1.4.0"
		},
		"developerMode" : false,
		"productionMode" : true,
		"staticServerFallbackUrl" : "https://sslstatic.wix.com/",
		"staticVideoUrl" : "https://video.wixstatic.com/",
		"cloudStorageUrl" : "https://static.wixstatic.com/",
		"scriptsDomainUrl" : "https://static.parastorage.com/",
		"userFilesUrl" : "https://static.parastorage.com/",
		"staticHTMLComponentUrl" : "https://djswprkwlsk1-wixsite-com.usrfiles.com/",
		"secured" : true,
		"ecommerceCheckoutUrl" : "https://www.safer-checkout.com/",
		"premiumServerUrl" : "https://premium.wix.com/",
		"digitalGoodsServerUrl" : "https://dgs.wixapps.net/",
		"wixCloudBaseDomain" : "wix-code.com",
		"mailServiceSuffix" : "/_api/common-services/notification/invoke",
		"staticVideoHeadRequestUrl" : "https://storage.googleapis.com/video.wixstatic.com",
		"protectedPageResolverUrl" : "https://site-pages.wix.com/_api/wix-public-html-info-webapp/resolve_protected_page_urls",
		"mediaUploadServerUrl" : "https://files.wix.com/",
		"publicStaticsUrl" : "https://static.parastorage.com/services/wix-public/1.231.0"
	};
	var santaModels = true;
	var rendererModel = {
		"metaSiteId" : "fc72b024-c09e-4ae0-8a9d-a518935949f8",
		"siteInfo" : {
			"documentType" : "UGC",
			"applicationType" : "HtmlWeb",
			"siteId" : "65dc45d2-5183-402c-895a-2002b60c0f51",
			"siteTitleSEO" : "finalp"
		},
		"clientSpecMap" : {
			"14" : {
				"type" : "public",
				"applicationId" : 14,
				"appDefinitionId" : "13c1402c-27f2-d4ab-7463-ee7c89e07578",
				"appDefinitionName" : "Wix Restaurants Menus",
				"instance" : "zyIBk2fTFlH7Njf0xreFpq5l3LJlg18rM2FTYOOnaUM.eyJpbnN0YW5jZUlkIjoiMGRjMjk4NGItY2U1Mi00ZmEyLWE0ZDktNTY4ZDM3OTNhMjJiIiwic2lnbkRhdGUiOiIyMDE3LTA2LTIwVDA1OjU2OjU4Ljc5OVoiLCJ1aWQiOm51bGwsImlwQW5kUG9ydCI6IjEuMjIwLjIzNi43NS82MjgxNiIsInZlbmRvclByb2R1Y3RJZCI6bnVsbCwiZGVtb01vZGUiOmZhbHNlLCJvcmlnaW5JbnN0YW5jZUlkIjoiMGRiNzhkMDEtZjQwNS00Y2M5LWFkODctNzhiOGVhZWQ3NDRiIiwiYWlkIjoiNGNiOWYzMGEtN2U2Yi00ZmI3LTgyZjgtN2NlMDBhMDFiNjY3IiwiYmlUb2tlbiI6ImYxYjAyODZmLTBlY2MtMDU0Mi0yZTQ0LWYzOTVhNGNhZWJkMyIsInNpdGVPd25lcklkIjoiMTc5OWJkY2QtZjhkMy00NTJjLWEyNGMtYjRjNDc1NzIwNjA5In0",
				"sectionUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixmenus.client",
				"sectionMobileUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixmenus.client",
				"sectionPublished" : true,
				"sectionMobilePublished" : true,
				"sectionSeoEnabled" : true,
				"sectionDefaultPage" : "",
				"sectionRefreshOnWidthChange" : true,
				"widgets" : {
					"13c1404b-b03b-ee00-84c1-51ae431a537f" : {
						"widgetUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixmenus.client",
						"widgetId" : "13c1404b-b03b-ee00-84c1-51ae431a537f",
						"refreshOnWidthChange" : true,
						"mobileUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixmenus.client",
						"appPage" : {
							"id" : "menu",
							"name" : "Menus",
							"defaultPage" : "",
							"hidden" : false,
							"multiInstanceEnabled" : true,
							"order" : 1,
							"indexable" : true,
							"fullPage" : false,
							"landingPageInMobile" : false,
							"hideFromMenu" : false
						},
						"published" : true,
						"mobilePublished" : true,
						"seoEnabled" : true,
						"preFetch" : false,
						"shouldBeStretchedByDefault" : false,
						"shouldBeStretchedByDefaultMobile" : false
					}
				},
				"appRequirements" : {
					"requireSiteMembers" : false
				},
				"isWixTPA" : true,
				"installedAtDashboard" : true,
				"permissions" : {
					"revoked" : false
				}
			},
			"1414" : {
				"type" : "public",
				"applicationId" : 1414,
				"appDefinitionId" : "14583ff5-e781-063a-3bc4-6b79fb966992",
				"appDefinitionName" : "Wix Restaurants Kit",
				"instance" : "jGA6v9BGDKjvSeP12lCnqMHnjs31auYZfzlgkI6c84Q.eyJpbnN0YW5jZUlkIjoiYzRkNmM2MTMtZjdhMi00NDBkLWI2NGItZDk3YWVhMTUxNzI0Iiwic2lnbkRhdGUiOiIyMDE3LTA2LTIwVDA1OjU2OjU4Ljc5OVoiLCJ1aWQiOm51bGwsImlwQW5kUG9ydCI6IjEuMjIwLjIzNi43NS82MjgxNiIsInZlbmRvclByb2R1Y3RJZCI6bnVsbCwiZGVtb01vZGUiOmZhbHNlLCJvcmlnaW5JbnN0YW5jZUlkIjoiMWZmMjg3OWMtYjliMy00Njg0LTg1OWEtYmU5YzU5ODc3YzQzIiwiYWlkIjoiZDJlYmU2MDAtMDk3ZC00MzBlLTgxYzAtOGY4YWI3MmRkYzAyIiwiYmlUb2tlbiI6IjM4YTQ3NjM3LTM3M2MtMGVlZC0zY2Q2LTdjNjI3OTRjNWVkYyIsInNpdGVPd25lcklkIjoiMTc5OWJkY2QtZjhkMy00NTJjLWEyNGMtYjRjNDc1NzIwNjA5In0",
				"sectionPublished" : true,
				"sectionMobilePublished" : false,
				"sectionSeoEnabled" : true,
				"widgets" : {
					"14584020-d28d-5e2e-678c-8af7fdd3f94c" : {
						"widgetUrl" : "https:\/\/apps.wixrestaurants.com\/?type=socialbar.client",
						"widgetId" : "14584020-d28d-5e2e-678c-8af7fdd3f94c",
						"refreshOnWidthChange" : true,
						"mobileUrl" : "https:\/\/apps.wixrestaurants.com\/?type=socialbar.client.mobile",
						"published" : true,
						"mobilePublished" : true,
						"seoEnabled" : true,
						"preFetch" : false,
						"shouldBeStretchedByDefault" : false,
						"shouldBeStretchedByDefaultMobile" : false
					}
				},
				"appRequirements" : {
					"requireSiteMembers" : false
				},
				"isWixTPA" : true,
				"installedAtDashboard" : true,
				"permissions" : {
					"revoked" : false
				}
			},
			"13" : {
				"type" : "sitemembers",
				"applicationId" : 13,
				"collectionType" : "Open",
				"collectionFormFace" : "Register",
				"smcollectionId" : "5e078987-679e-48c6-a6ee-2923cd44640a"
			},
			"2" : {
				"type" : "appbuilder",
				"applicationId" : 2,
				"appDefinitionId" : "3d590cbc-4907-4cc4-b0b1-ddf2c5edf297",
				"instanceId" : "ae4cfba3-1f11-4b9a-a14f-acaf3e6714b9",
				"state" : "Initialized"
			},
			"1000" : {
				"type" : "public",
				"applicationId" : 1000,
				"appDefinitionId" : "13e8d036-5516-6104-b456-c8466db39542",
				"appDefinitionName" : "Wix Restaurants Orders",
				"instance" : "9XOgcSVHXFbh-67wPs6SYuUAsrEvHX_S00hdKrXVTt8.eyJpbnN0YW5jZUlkIjoiNmFhZWExNjEtOGQzOS00ZWIxLTgyOWYtZmRhZjA3MDJlZmY1Iiwic2lnbkRhdGUiOiIyMDE3LTA2LTIwVDA1OjU2OjU4Ljc5OVoiLCJ1aWQiOm51bGwsImlwQW5kUG9ydCI6IjEuMjIwLjIzNi43NS82MjgxNiIsInZlbmRvclByb2R1Y3RJZCI6bnVsbCwiZGVtb01vZGUiOmZhbHNlLCJvcmlnaW5JbnN0YW5jZUlkIjoiOWQ5YjYzZmUtYmExMy00ZDM1LWI4YWUtNGEzNjI5YWQxN2MwIiwiYWlkIjoiYjgxYWVmYzUtZGVhZC00YjEwLTkxZjctM2IxZjRmMzhjYTBjIiwiYmlUb2tlbiI6Ijk2ZGMxMTQ1LTRkYTctMDQ1MS0wODAyLTU4Yjc5NDViYTYwZCIsInNpdGVPd25lcklkIjoiMTc5OWJkY2QtZjhkMy00NTJjLWEyNGMtYjRjNDc1NzIwNjA5In0",
				"sectionUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixorders.client",
				"sectionMobileUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixorders.client.mobile",
				"appWorkerUrl" : "https:\/\/ding.wix.com\/asdk\/dispatcher.html",
				"sectionPublished" : true,
				"sectionMobilePublished" : true,
				"sectionSeoEnabled" : true,
				"sectionDefaultPage" : "",
				"sectionRefreshOnWidthChange" : true,
				"widgets" : {
					"13e8d047-31b9-9c1f-4f89-48ba9430f838" : {
						"widgetUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixorders.client",
						"widgetId" : "13e8d047-31b9-9c1f-4f89-48ba9430f838",
						"refreshOnWidthChange" : true,
						"mobileUrl" : "https:\/\/apps.wixrestaurants.com\/?type=wixorders.client.mobile",
						"appPage" : {
							"id" : "online_ordering",
							"name" : "Online Ordering",
							"defaultPage" : "",
							"hidden" : false,
							"multiInstanceEnabled" : true,
							"order" : 1,
							"indexable" : true,
							"fullPage" : false,
							"landingPageInMobile" : false,
							"hideFromMenu" : false
						},
						"published" : true,
						"mobilePublished" : true,
						"seoEnabled" : true,
						"preFetch" : false,
						"shouldBeStretchedByDefault" : false,
						"shouldBeStretchedByDefaultMobile" : false
					}
				},
				"appRequirements" : {
					"requireSiteMembers" : false
				},
				"isWixTPA" : true,
				"installedAtDashboard" : true,
				"permissions" : {
					"revoked" : false
				}
			}
		},
		"premiumFeatures" : [],
		"geo" : "KOR",
		"languageCode" : "ko",
		"previewMode" : false,
		"userId" : "1799bdcd-f8d3-452c-a24c-b4c475720609",
		"siteMetaData" : {
			"preloader" : {
				"uri" : "",
				"enabled" : false
			},
			"adaptiveMobileOn" : true,
			"quickActions" : {
				"socialLinks" : [],
				"colorScheme" : "dark",
				"configuration" : {
					"quickActionsMenuEnabled" : false,
					"navigationMenuEnabled" : true,
					"phoneEnabled" : false,
					"emailEnabled" : false,
					"addressEnabled" : false,
					"socialLinksEnabled" : false
				}
			},
			"contactInfo" : {
				"companyName" : "",
				"phone" : "",
				"fax" : "",
				"email" : "",
				"address" : ""
			}
		},
		"runningExperiments" : {
			"sv_blogRealPagination" : "new",
			"appMarketCache" : "new",
			"sv_textLinkWhiteList" : "new",
			"sv_platform1" : "new",
			"reactAppMarketModals" : "new",
			"sv_hoverBox" : "new",
			"sv_dpages" : "new",
			"clickToAction_email" : "new",
			"sv_smSocialLoginEnabledByDefault" : "new",
			"sv_ampLinkTag" : "new",
			"connectionsData" : "new",
			"sv_remove_headTagsSaveDataFixer" : "new",
			"sv_twitterMetaTags" : "new",
			"sv_blogTranslateErrorMessage" : "new",
			"sv_listsBatchRequest" : "new",
			"sv_blogRelatedPosts" : "new",
			"noDynamicModelOnFirstLoad" : "new",
			"sv_expandModeBi" : "new",
			"sv_reportPerformance" : "new",
			"clickToAction_url" : "new",
			"sv_cssDesignData" : "new",
			"useBeaconForPerformanceEvent" : "new",
			"sv_blogCountersHttpsRequest" : "new",
			"viewPortImageLoadingBi" : "3000",
			"useBeacon" : "new",
			"sv_dataItemRefsSaveDataFixer_bi" : "new",
			"sv_webpJPGSupport" : "new",
			"sv_addFirstTimeRenderBiEvents" : "new",
			"reactAppMarket" : "new",
			"sv_delelteItemsRecursively" : "new",
			"fontsTrackingInViewer" : "new",
			"tpaHideFromMenu" : "new",
			"sv_blogSocialCounters" : "new",
			"sv_addJsonldToHeadForSEO" : "new",
			"sv_remove_backgroundsSaveDataFixer" : "new",
			"clickToAction_phone" : "new",
			"viewPortImageLoading" : "new",
			"allowScriptTagTypeJsonOnSeoMetatag" : "old",
			"sv_fixColorOfHatulOnHover" : "new",
			"autosaveTpaSettle" : "new",
			"retryOnConcurrencyError" : "new",
			"permalinkWithoutDate" : "new",
			"ds_syncDeletedItemsFromServer" : "new",
			"sv_faviconFromServer" : "new",
			"pageListNewFormat" : "new",
			"sv_blogAuthorAsALink" : "new",
			"se_ignoreBottomBottomAnchors" : "new",
			"ds_saveState" : "new",
			"packagescache" : "new",
			"fontScaling" : "new",
			"autosaveWixappsSettle" : "new",
			"sv_tpaMultiWidget" : "new",
			"operationsQAllAsync" : "new",
			"hashPasswordOnServer" : "new",
			"remove_mobile_props_and_design_if_really_deleted" : "new",
			"sv_tpaAddChatApp" : "new",
			"sv_permissionInfoUpdateOnFirstSave" : "new",
			"sv_blogOldUrlShareFix" : "new",
			"sv_SendSdkMethodBI" : "new",
			"sv_addBorderToElementBounds" : "new",
			"sv_blogNotifySocialCounters" : "new",
			"sv_qab" : "new",
			"sv_blogLikeCounters" : "new",
			"sv_robotsIndexingMetaTag" : "new",
			"sv_blogNewSocialShareButtonsInTemplates" : "new",
			"sv_ignoreBottomBottomAnchors" : "new",
			"sv_addBlogPerformanceBiEvents" : "new",
			"sv_grid" : "new",
			"sv_NewFacebookConversionPixel" : "new",
			"sv_tpaPerformanceBi" : "new",
			"sv_unpackTextMeasureByMinHeight" : "new",
			"wixCodeBinding" : "new",
			"sv_alwaysEnableMobileZoom" : "new",
			"contactFormActivity" : "old"
		},
		"urlFormatModel" : {
			"format" : "slash",
			"forbiddenPageUriSEOs" : [ "app", "apps", "_api", "robots.txt",
					"sitemap.xml", "feed.xml", "sites" ],
			"pageIdToResolvedUriSEO" : {}
		},
		"passwordProtectedPages" : [],
		"useSandboxInHTMLComp" : true,
		"siteMediaToken" : "eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcHA6MzQ2NjQ5MDcwMDI5NzIwNiIsInN1YiI6InVzZXI6MTc5OWJkY2QtZjhkMy00NTJjLWEyNGMtYjRjNDc1NzIwNjA5IiwiYXVkIjoidXJuOnNlcnZpY2U6ZmlsZS51cGxvYWQiLCJleHAiOjE0OTg1NDMwMTgsImlhdCI6MTQ5NzkzODIxOCwianRpIjoiSVYxWFpyUGxpRk95MnVmSkdyNDY3dyJ9.m7hZakJO3OnwT1Imw1SQkOeTXyO1Rij7AuxUDxqEURE",
		"pagesPlatformApplications" : {}
	};
	var publicModel = {
		"domain" : "wixsite.com",
		"externalBaseUrl" : "https:\/\/djswprkwlsk1.wixsite.com\/finalp",
		"unicodeExternalBaseUrl" : "https:\/\/djswprkwlsk1.wixsite.com\/finalp",
		"pageList" : {
			"pages" : [
					{
						"pageId" : "mainPage",
						"title" : "Home",
						"pageUriSEO" : "home",
						"pageJsonFileName" : "1799bd_9af86f9daeb5c1e995bdc7f5ef090478_9.json"
					},
					{
						"pageId" : "cjg9",
						"title" : "About",
						"pageUriSEO" : "about",
						"pageJsonFileName" : "1799bd_25f0506fcd3ca9a7284a1871ebfabfca_1.json"
					},
					{
						"pageId" : "c30g",
						"title" : "Menu",
						"pageUriSEO" : "menu",
						"pageJsonFileName" : "1799bd_bab5c065887d6c8faea8d1bae0e57536_1.json"
					},
					{
						"pageId" : "c1uuh",
						"title" : "Contact",
						"pageUriSEO" : "contact",
						"pageJsonFileName" : "1799bd_43f417ed409e71e9e053ed5f704c3f5e_1.json"
					},
					{
						"pageId" : "ib5j4",
						"title" : "Order Online",
						"pageUriSEO" : "order-online",
						"pageJsonFileName" : "1799bd_4bf356e7c30b5a32a2cd7c19944a970e_1.json"
					},
					{
						"pageId" : "cfvg",
						"title" : "Press",
						"pageUriSEO" : "press",
						"pageJsonFileName" : "1799bd_966fe2b03e9bc55b577c8e507e91792b_1.json"
					} ],
			"mainPageId" : "mainPage",
			"masterPageJsonFileName" : "1799bd_fa2b20385667ccab42f63fd6dedf6499_8.json",
			"topology" : [ {
				"baseUrl" : "https:\/\/static.wixstatic.com\/",
				"parts" : "sites\/{filename}.z?v=3"
			}, {
				"baseUrl" : "https:\/\/staticorigin.wixstatic.com\/",
				"parts" : "sites\/{filename}.z?v=3"
			}, {
				"baseUrl" : "https:\/\/fallback.wix.com\/",
				"parts" : "wix-html-editor-pages-webapp\/page\/{filename}"
			} ]
		},
		"timeSincePublish" : 3218,
		"favicon" : "",
		"deviceInfo" : {
			"deviceType" : "Desktop",
			"browserType" : "Chrome",
			"browserVersion" : 58
		},
		"siteRevision" : 9,
		"sessionInfo" : {
			"hs" : -157582507,
			"svSession" : "cce71f57ffcdbe4ee9687f2f9ca282d1808b66dd1650283252f7b8a2995fff3d2599188a31d4bb09f38aa0da3d8e9cdc1e60994d53964e647acf431e4f798bcd457b7a2ad321b1aac1be0be3e36ea47d6e034c03ca6f24057263192c6ff81ed1",
			"ctToken" : "T0pOQlN1bjF0OTlfSF9lWmh4TFpXMWEwWmV0eGlRNGZ5aTlMcmdJMXNHVXx7InVzZXJBZ2VudCI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDYuMTsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzU4LjAuMzAyOS4xMTAgU2FmYXJpLzUzNy4zNiIsInZhbGlkVGhyb3VnaCI6MTQ5ODU0MzAxODc5OX0",
			"isAnonymous" : false
		},
		"metaSiteFlags" : [],
		"siteMembersProtectedPages" : [],
		"indexable" : true,
		"hasBlogAmp" : false
	};

	var googleAnalytics = "UA-2117194-61";

	var googleRemarketing = "";
	var facebookRemarketing = "";
	var yandexMetrika = "";
</script>



<meta name="fragment" content="!" />

<!-- DATA -->
<script type="text/javascript">
	var adData = {
		"topLabel" : "<span class=\"smallMusa\">(Wix-Logo) </span><span class=\"smallLogo\">Wix</span> 로 홈페이지를 만들어보세요!",
		"topContent" : "수백 가지 템플릿<br />코딩없이 제작 가능<br /><span class=\"emphasis spacer\">시작하기 >></span>",
		"footerLabel" : "<div class=\"adFootBox\"><div class=\"siteBanner\" ><div class=\"siteBanner\"><div class=\"wrapper\"><div class=\"bigMusa\">(Wix Logo)</div><div class=\"txt shd\" style=\"color:#fff\">이 사이트는 </div> <div class=\"txt shd\"><a  href=\"http://ko.wix.com?utm_campaign=vir_wixad_live\" style=\"color:#fff\">WIX.com</a></div> <div class=\"txt shd\" style=\"color:#fff\">으로 제작되었습니다. 나만의 홈페이지를 무료로 만들어보세요<span class=\"emphasis\"> >></span></div></div></div></div></div>",
		"adUrl" : "http://ko.wix.com/lpviral/ko900viral?utm_campaign=vir_wixad_live"
	};
	var mobileAdData = {
		"footerLabel" : "7c3dbd_22c49c4f23a545228a6ccc9b5b3f16f7.jpg",
		"adUrl" : "http://ko.wix.com?utm_campaign=vir_wixad_live"
	};
	var usersDomain = "https://users.wix.com/wix-users";
</script>
</head>
<body>
	<div id="SITE_CONTAINER"></div>




	<div comp="wysiwyg.viewer.components.WixAds"
		skin="wysiwyg.viewer.skins.wixadsskins.WixAdsWebSkin" id="wixFooter"></div>




</body>
</html>
