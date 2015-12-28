<!DOCTYPE html>
<html>
<head>
	<title>Spring Cloud S3 Example</title>
	<meta charset="utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>

	<link rel="stylesheet" type="text/css" href="http://axicon.axisj.com/axicon/axicon.css">
	<link rel="stylesheet" type="text/css" href="http://dev.axisj.com/ui/kakao/AXJ.min.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="http://dev.axisj.com/dist/AXJ.min.js"></script>
	<style>
		html, body{
			margin:0px; padding:0px;
			height: 100%;
			overflow: hidden;
			font-size: 12px;
		}

		h1{
			font-size: 24px;
			padding: 10px; margin: 0px;
		}
		.block{
			padding: 10px;
		}
		.AXUpload5QueueBox_list .AXUploadItem .AXUploadTit{
			white-space: nowrap;
		}
	</style>
</head>
<body>

<table cellpadding="0" cellspacing="0" style="height:100%;width:100%;">
	<tr>
		<td valign="top">
			<div class="block">
				<h1>
					<i class="axi axi-file"></i> Uploaded list
				</h1>
				<div id="uploaded-list"></div>
			</div>
		</td>
		<td valign="top" width="30%" style="border-left: 2px solid #d8d8d8;">
			<div class="block">
				<h1>
					<i class="axi axi-ion-gear-b"></i> File infomation
				</h1>
				<div id="file-view">

				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2" height="250" style="border-top: 2px solid #d8d8d8;background: #eee;">
			<div class="block">

				<div class="AXUpload5" id="AXUpload5"></div>

				<div style="height:10px;"></div>

				<div id="uploadQueueBox" class="AXUpload5QueueBox_list" style="height:188px;"></div>

				<!--
				<form action="/api/aws/s3/upload" enctype="multipart/form-data" method="POST">
					<input type="file" name="file"/>
					<input type="file" name="file"/>
					<input type="file" name="file"/>
					<input type="file" name="file"/>
					<input type="file" name="file"/>
					<input type="submit" value="Submit"/>
				</form>
				-->
			</div>

		</td>
	</tr>
	<tr>
		<td valign="top" colspan="2" height="30" style="border-top: 2px solid #d8d8d8;background: #000;line-height: 28px;color:#fff;text-align: center;">
			Opensource javascript UI Library AXISJ - <a href="https://github.com/axisj/axisj" style="color: #fff;">https://github.com/axisj/axisj</a>
		</td>
	</tr>
</table>

<script type="text/javascript">
	var fnObj = {
		pageStart: function(){
			this.grid.init();
			this.view.init();
			this.upload.init();
		},
		pageResize: function(){
			var body_height = axf.clientHeight();
			this.grid.target_dom.css({height:body_height - 360});
			this.grid.target.resetHeight();
		},
		grid: {
			target_dom: "",
			target: new AXGrid(),
			init: function(){
				this.target_dom = $("#uploaded-list");
				this.target.setConfig({
					targetID : "uploaded-list",
					theme : "AXGrid",
					colGroup : [
						{key:"bucketName", label:"bucketName", width:"100", align:"center"},
						{key:"key", label:"key", width:"200"},
						{key:"size", label:"size", width:"80", align:"right", formatter:function(){
							return this.value.byte();
						}},
						{key:"lastModified", label:"lastModified", width:"100", align:"center", formatter: function(){
							return this.value.date().print();
						}},
						{key:"storageClass", label:"storageClass", width:"100"},
						{key:"owner", label:"owner", width:"80", formatter: function(){
							return this.value.displayName;
						}},
						{key:"etag", label:"etag", width:"200"}
					],
					body : {
						onclick: function(){
							//toast.push(Object.toJSON({index:this.index, item:this.item}));
							fnObj.view.set(this.item);
						}
					},
					page:{
						paging:false
					}
				});
				this.query();
			},
			query: function(){
				$.ajax({
							url: "/api/aws/s3/list",
							beforeSend: function( xhr ) {
								//xhr.overrideMimeType( "text/plain; charset=x-user-defined" );
							}
						})
						.done(function( data ) {

							fnObj.grid.target.setList(data);

						});
			}
		},
		view: {
			target: "",
			init: function() {
				this.target = $("#file-view");
			},
			set: function(item){
				this.item = item;
				var po = [];



				po.push('<table cellpadding="0" cellspacing="0" class="AXFormTable">');
				po.push('	<colgroup>');
				po.push('		<col width="100" />');
				po.push('		<col />');
				po.push('	</colgroup>');
				po.push('	<tbody>');
				po.push('		<tr>');
				po.push('			<th>bucketName</th>');
				po.push('			<td>'+ item.bucketName );
				po.push('			</td>');
				po.push('		<tr>');
				po.push('		<tr>');
				po.push('			<th>파일명</th>');
				po.push('			<td>'+ item.key );
				po.push('			</td>');
				po.push('		<tr>');
				po.push('		<tr>');
				po.push('			<th>사이즈</th>');
				po.push('			<td>' + item.size.byte() );
				po.push('			</td>');
				po.push('		<tr>');
				po.push('		<tr>');
				po.push('			<th>lastModified</th>');
				po.push('			<td>' + item.lastModified.date() );
				po.push('			</td>');
				po.push('		<tr>');
				po.push('		<tr>');
				po.push('			<th>storageClass</th>');
				po.push('			<td>' + item.storageClass );
				po.push('			</td>');
				po.push('		<tr>');
				po.push('		<tr>');
				po.push('			<th>owner</th>');
				po.push('			<td>' + Object.toJSON(item.owner) );
				po.push('			</td>');
				po.push('		<tr>');
				po.push('		<tr>');
				po.push('			<th>etag</th>');
				po.push('			<td>' + item.etag );
				po.push('			</td>');
				po.push('		<tr>');
				po.push('	</tbody>');
				po.push('</table>');

				po.push('<div style="padding: 10px;">');
				po.push('<button class="AXButton Classic" onclick="fnObj.view.download();"><i class="axi axi-cloud-download"></i> 다운로드</button>');
				po.push('</div>');

				this.target.html( po.join('') );
			},
			download: function(){
				location.href = ('/api/aws/s3/download?key=' + this.item.key);
			}
		},
		upload: {
			target: new AXUpload5(),
			init: function(){
				var target = this.target;
				this.target.setConfig({
					targetID:"AXUpload5",
					targetButtonClass:"Classic",
					uploadFileName:"file",
					file_types:"*/*",  //audio/*|video/*|image/*|MIME_type (accept)
					dropBoxID:"uploadQueueBox",
					queueBoxID:"uploadQueueBox", // upload queue targetID

					// --------- e
					onClickUploadedItem: function(){ // 업로드된 목록을 클릭했을 때.
						window.open(this.uploadedPath.dec() + this.saveName.dec(), "_blank", "width=500,height=500");
					},

					uploadMaxFileSize:(1000*1024*1024), // 업로드될 개별 파일 사이즈 (클라이언트에서 제한하는 사이즈 이지 서버에서 설정되는 값이 아닙니다.)
					uploadMaxFileCount:10, // 업로드될 파일갯수 제한 0 은 무제한
					uploadUrl:"/api/aws/s3/upload",
					uploadPars:{},
					deleteUrl:"/api/aws/s3/upload",
					deletePars:{},

					buttonTxt:'<i class="axi axi-cloud-upload"></i>&nbsp;&nbsp; 파일올리기',

					fileKeys:{ // 서버에서 리턴하는 json key 정의 (id는 예약어 사용할 수 없음)
						//id:"id",
						name:"name",
						type:"type",
						saveName:"saveName",
						fileSize:"fileSize",
						uploadedPath:"uploadedPath",
						thumbPath:"thumbUrl" // 서버에서 키값을 다르게 설정 할 수 있다는 것을 확인 하기 위해 이름을 다르게 처리한 예제 입니다.
					},

					onbeforeFileSelect: function(){
						trace(this);
						return true;
					},

					onUpload: function(){
						//trace(this);
						//trace(myUpload.uploadedList);
						//trace("onUpload");
					},
					onComplete: function(){
						//trace(this);
						toast.push(target.uploadedList.length + "건의 파일이 업로드 되었습니다.");

						target.setUploadedList([]);
						$("#uploadQueueBox").empty();

						fnObj.grid.query();
						// $("#uploadCancelBtn").get(0).disabled = true; // 전송중지 버튼 제어
					},
					onStart: function(){
						//trace(this);
						//trace("onStart");
						// $("#uploadCancelBtn").get(0).disabled = false; // 전송중지 버튼 제어
					},
					onDelete: function(){
						trace(this);
						//trace("onDelete");
					},
					onError: function(errorType, extData){
						if(errorType == "html5Support"){
							//dialog.push('The File APIs are not fully supported in this browser.');
						}else if(errorType == "fileSize"){
							//trace(extData);
							alert("파일사이즈가 초과된 파일을 업로드 할 수 없습니다. 업로드 목록에서 제외 합니다.\n("+extData.name+" : "+extData.size.byte()+")");
						}else if(errorType == "fileCount"){
							alert("업로드 갯수 초과 초과된 아이템은 업로드 되지 않습니다.");
						}
					}
				});
				// changeConfig


			}
		}
	};

	$(document.body).ready(function(){
		fnObj.pageStart();
		fnObj.pageResize();
	});
	$(window).resize(function(){
		fnObj.pageResize();
	});
</script>
</body>
</html>