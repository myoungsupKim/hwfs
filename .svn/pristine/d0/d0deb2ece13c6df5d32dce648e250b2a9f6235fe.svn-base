package com.hwfs.ms.msc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.msc.dao.SaniImgDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 위생점검결과조회 SaniImg Service Implementation
 * 
 * @ClassName FoodReservesReportServiceImpl.java
 * @Description FoodReservesReportServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/msc/saniImgService")
public class SaniImgServiceImpl extends DefaultServiceImpl implements SaniImgService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FoodReservesReportDAO Bean 생성 */
	@Resource(name = "/ms/msc/saniImgDAO")
	private SaniImgDAO saniImgDAO;		
	
	/**
	 * 위생점검결과 목록을 조회한다.
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return saniImgDAO.selectList(mapParam);
	}
	
	public RecordSet selectCommonCdList(Map<String, Object> mapParam) throws Exception {
		return saniImgDAO.selectCommonCdList(mapParam);
	}

	
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap dsImgList, DataSetMap dsInput, LoginDTO loginDTO) throws Exception {

		int insRow = 0;
		int updRow = 0;
		
		if(dsInput.get(0).get("imgType").equals("checkImg")) {
			// 점검이미지 신규등록
			for (int i=0; i<dsImgList.size(); i++) {
				Map<String, Object> imgRow =  dsImgList.get(i);
				
				
				// 점검이미지 신규 등록
				if(imgRow.get("chk").equals("1")) {
					imgRow.put("tableType", dsInput.get(0).get("tableType"));
					imgRow.put("formCd", dsInput.get(0).get("formCd"));
					imgRow.put("upjang", dsInput.get(0).get("upjang"));
					imgRow.put("chkDd", dsInput.get(0).get("chkDd"));
					imgRow.put("classCd", dsInput.get(0).get("classCd"));
					imgRow.put("sabun",  loginDTO.getSabun());
					
					//file:///var/mobile/Containers/Data/Application/DB1DEDEF-54D0-46E8-9D9C-D06279A2944B/Documents/temp/fsp_20220913162623.png
					String orgnImgeTemp = "";
					if(imgRow.get("orgnlImge").toString() != "") {
						String[] orgnName = imgRow.get("orgnlImge").toString().split("/");
						orgnImgeTemp = orgnName[orgnName.length-1];
						imgRow.put("orgnlImge", orgnImgeTemp);
					}
					
					insRow += saniImgDAO.insertCheckImg(imgRow);
				}
				
			}
		
		} else if (dsInput.get(0).get("imgType").equals("improveImg")) {
			// 개선이미지 등록
			for (int i=0; i<dsImgList.size(); i++) {
				Map<String, Object> imgRow =  dsImgList.get(i);
				
				
				if(imgRow.get("chk").equals("1") && imgRow.get("improvSvrImge")!="") {
					imgRow.put("tableType", dsInput.get(0).get("tableType"));
					imgRow.put("formCd", dsInput.get(0).get("formCd"));
					imgRow.put("upjang", dsInput.get(0).get("upjang"));
					imgRow.put("chkDd", dsInput.get(0).get("chkDd"));
					imgRow.put("classCd", dsInput.get(0).get("classCd"));
					imgRow.put("sabun",  loginDTO.getSabun());
					
					//file:///var/mobile/Containers/Data/Application/DB1DEDEF-54D0-46E8-9D9C-D06279A2944B/Documents/temp/fsp_20220913162623.png
					String orgnImgeTemp = "";
					if(imgRow.get("improvOrgnlImge").toString() != "") {
						String[] orgnName = imgRow.get("improvOrgnlImge").toString().split("/");
						orgnImgeTemp = orgnName[orgnName.length-1];
						imgRow.put("improvOrgnlImge", orgnImgeTemp);
					}
					
					//System.out.println("imgRow"+imgRow);
					updRow += saniImgDAO.updateImproveImg(imgRow);
				}
			}
		} else {
			// 이미지 등록 없음
		}
		
		
		
		
//<Row>
//<Col id="orgnlImge">file:///var/mobile/Containers/Data/Application/DB1DEDEF-54D0-46E8-9D9C-D06279A2944B/Documents/temp/fsp_20220913162623.png</Col>
//<Col id="svrImge">true_undefined_0.jpg</Col>
//<Col id="fileSize">1182400</Col>
//<Col id="photoType">0</Col>
//<Col id="chk">1</Col>
//</Row>

		
		
//		dsInput index >>>>> 0
//		dsInput detailRow >>>>> {formCd=202207, chkDd=20220902, tableType=001, classCd=01001001, upjang=148682, ROW_TYPE=0}
//		dsImgList index >>>>> 0
//		dsImgList detailRow >>>>> {uuser=210217, filePath=, improvYn=미등록, udate=20220905162744000, orgnlImge=KakaoTalk_20220902_093711506_03.jpg, improvSvrImge=, formCd=202207, chk=0, chkDd=20220902, preView=KakaoTalk_20220902_093711506_03_20220905162744070.jpg, tableType=001, improvFileSize=, upjang=148682, photoType=1, improvFilePath=, cuser=210217, cdate=20220905162744000, svrImge=KakaoTalk_20220902_093711506_03_20220905162744070.jpg, improvOrgnlImge=, srlnum=222497, classCd=01001001, improvPreView=, fileSize=203940, ROW_TYPE=0}
//		dsImgList index >>>>> 1
//		dsImgList detailRow >>>>> {uuser=210217, filePath=, improvYn=미등록, udate=20220905162731000, orgnlImge=KakaoTalk_20220902_093711506_04.jpg, improvSvrImge=, formCd=202207, chk=0, chkDd=20220902, preView=KakaoTalk_20220902_093711506_04_20220905162731408.jpg, tableType=001, improvFileSize=, upjang=148682, photoType=0, improvFilePath=, cuser=210217, cdate=20220905162731000, svrImge=KakaoTalk_20220902_093711506_04_20220905162731408.jpg, improvOrgnlImge=, srlnum=222496, classCd=01001001, improvPreView=, fileSize=461090, ROW_TYPE=0}
//		dsImgList index >>>>> 2
//		dsImgList detailRow >>>>> {svrImge=none_210217_0_20220915102209756.jpg, orgnlImge=file:///var/mobile/Containers/Data/Application/9E4D96E9-53A8-4FDE-BF79-734353D894CC/Documents/temp/fsp_20220915102202.png, chk=1, photoType=0, fileSize=2422865, ROW_TYPE=0}

		
		
		// 개선이미지 등록 DS 샘플
//		<Row>
//		<Col id="srlnum">222497</Col>
//		<Col id="tableType">001</Col>
//		<Col id="formCd">202207</Col>
//		<Col id="upjang">148682</Col>
//		<Col id="chkDd">20220902</Col>
//		<Col id="classCd">01001001</Col>
//		<Col id="orgnlImge">KakaoTalk_20220902_093711506_03.jpg</Col>
//		<Col id="svrImge">KakaoTalk_20220902_093711506_03_20220905162744070.jpg</Col>
//		<Col id="fileSize">203940</Col>
//		<Col id="improvOrgnlImge">0cutieBoss.jpg</Col>
//		<Col id="improvSvrImge">0cutieBoss_20220917123642347.jpg</Col>
//		<Col id="improvFileSize">1680683</Col>
//		<Col id="cuser">210217</Col>
//		<Col id="cdate">20220905162744000</Col>
//		<Col id="uuser">210217</Col>
//		<Col id="udate">20220917123642000</Col>
//		<Col id="photoType">1</Col>
//		<Col id="improvYn">등록</Col>
//		<Col id="preView">KakaoTalk_20220902_093711506_03_20220905162744070.jpg</Col>
//		<Col id="filePath" />
//		<Col id="improvPreView">0cutieBoss_20220917123642347.jpg</Col>
//		<Col id="improvFilePath" />
//		<Col id="chk">0</Col>
//	</Row>
//	<Row>
//		<Col id="srlnum">222496</Col>
//		<Col id="tableType">001</Col>
//		<Col id="formCd">202207</Col>
//		<Col id="upjang">148682</Col>
//		<Col id="chkDd">20220902</Col>
//		<Col id="classCd">01001001</Col>
//		<Col id="orgnlImge">KakaoTalk_20220902_093711506_04.jpg</Col>
//		<Col id="svrImge">KakaoTalk_20220902_093711506_04_20220905162731408.jpg</Col>
//		<Col id="fileSize">461090</Col>
//		<Col id="improvOrgnlImge">file:///var/mobile/Containers/Data/Application/BCF4246A-594D-4055-8AD6-5A82534C7227/Documents/temp/fsp_20220917135625.png</Col>
//		<Col id="improvSvrImge">none_210217_0_20220917135637868.jpg</Col>
//		<Col id="improvFileSize">2786552</Col>
//		<Col id="cuser">210217</Col>
//		<Col id="cdate">20220905162731000</Col>
//		<Col id="uuser">210217</Col>
//		<Col id="udate">20220905162731000</Col>
//		<Col id="photoType">0</Col>
//		<Col id="improvYn">미등록</Col>
//		<Col id="preView">KakaoTalk_20220902_093711506_04_20220905162731408.jpg</Col>
//		<Col id="filePath" />
//		<Col id="improvPreView" />
//		<Col id="improvFilePath" />
//		<Col id="chk">0</Col>
//	</Row>
		
//		<Dataset id="ds_input">
//		<ColumnInfo>
//			<Column id="tableType" type="STRING" size="256"  />
//			<Column id="formCd" type="STRING" size="256"  />
//			<Column id="upjang" type="STRING" size="256"  />
//			<Column id="chkDd" type="STRING" size="256"  />
//			<Column id="classCd" type="STRING" size="256"  />
//			<Column id="imgType" type="STRING" size="256"  />
//		</ColumnInfo>
//		<Rows>
//			<Row>
//				<Col id="tableType">001</Col>
//				<Col id="formCd">202207</Col>
//				<Col id="upjang">148682</Col>
//				<Col id="chkDd">20220902</Col>
//				<Col id="classCd">01001001</Col>
//				<Col id="imgType">improveImg</Col>
//			</Row>
		
		
		return insRow+updRow;
	}

	@Override
	public int deleteList(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception {
		
		int resultCnt=0;
		mapParam.put("sabun", loginDTO.getSabun());
		String checkImg = mapParam.get("imageType").toString();
		String slrnum = mapParam.get("srlnum").toString();
		
		if(slrnum == "" || slrnum.equals("")) {
			resultCnt = -1;
		} else {
			if(checkImg.equals("checkImg")) {
				//점검사진삭제
				resultCnt = saniImgDAO.deleteCheckImg(mapParam);
			} else {
				//개선사진삭제
				resultCnt = saniImgDAO.deleteImproveImg(mapParam);
			}
		}
		
		return resultCnt;
	}
}
