package com.hwfs.sc.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.FtpUtil;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LmsMmsDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.LmsMmsSendService;


 /**
 * LMS/MMS를 전송하는 LmsMmsSend Controller
 * @ClassName LmsMmsSendController.java
 * @Description LmsMmsSendController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/lmsMmsSend/")
public class LmsMmsSendController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LmsMmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/lmsMmsSendService")
	private LmsMmsSendService lmsMmsSendService;
	
	/**
	 * LMS/MMS 전송 목록을 조회한다.
	 * <pre>
	 * - 업무팀에서 업무에 맞게 개발해야 함
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//LMS/MMS 전송 을(를) 조회한다.
		RecordSet rs = lmsMmsSendService.selectListLmsMms(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * LMS/MMS 전송(을)를 Insert 처리한다.
	 * <pre>
	 * - LMS/MMS IF 테이블에 Insert만 존재
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> dsMap = xpDTO.getInDataSetMap();
		DataSetMap parameter = dsMap.get("ds_list");
		DataSetMap dsFile = dsMap.get("ds_file");

		//로그인 정보
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		
		//받는사람 목록이 전달되므로 DTO ArrayList로 변환
		String strHpList = (String)parameter.get(0).get("hpList");
		String[] arrHpList = strHpList.split(";");
		
		String strSubject = (String)parameter.get(0).get("subject");
		String strMsg = (String)parameter.get(0).get("msg");
		String strSendType = (String)parameter.get(0).get("sendType");
		
		List<LmsMmsDTO> lmsMmsList = new ArrayList<LmsMmsDTO>();
		for (int i=0; i<arrHpList.length; i++) {
			LmsMmsDTO lmsMmsDTO = new LmsMmsDTO();
			lmsMmsDTO.setPhone(arrHpList[i]);	//수신자 전화번호
			lmsMmsDTO.setSubject(strSubject);	//전송 제목
			lmsMmsDTO.setMsg(strMsg);			//전송 메시지
			
			//송신자번호가 없는 경우는 기본 전화번호로 설정한다. (업무에 따라 설정)
			lmsMmsDTO.setCallback(propertiesService.getString("ems.sms.callback.no", ""));
			
			//전송할 시간 : 생략하면 현재 시간
			//lmsMmsDTO.setReqDate("20150501 1200");
			
			lmsMmsDTO.setTrDeptId(loginDTO.getDeptId());
			lmsMmsDTO.setTrCcId(loginDTO.getCcCd());
			lmsMmsDTO.setTrUserId(loginDTO.getSabun());
			lmsMmsDTO.setTrCustNo("");			//테스트용이며, 업무에서는 수신자의 사업장코드로 설정한다.
			
			//전송파일 설정
			if (strSendType.equals("mms")) {
				for (int j=0; j<dsFile.size(); j++) {
					String filePath = propertiesService.getString("ems.ftp.rootDir") + 
									  propertiesService.getString("ems.ftp.mms.homeDir") + "/" + 
									  (String)dsFile.get(j).get("fileUploadNm");
					
					switch (j) {
					case 0 :
						lmsMmsDTO.setFilePath1(filePath); break;					
					case 1 :
						lmsMmsDTO.setFilePath2(filePath); break;
					case 2 :
						lmsMmsDTO.setFilePath3(filePath); break;
					case 3 :
						lmsMmsDTO.setFilePath4(filePath); break;
					case 4 :
						lmsMmsDTO.setFilePath5(filePath); break;
					default :
						lmsMmsDTO.setFilePath1(filePath); break;
					}
				}
				//파일 갯수
				lmsMmsDTO.setFileCnt(dsFile.size());
			}
			
			lmsMmsList.add(lmsMmsDTO);
		}
		
		//파일을 업로드 한다. 실운영에서만 업로드한다.
		if (strSendType.equals("mms")) { // && !propertiesService.getBoolean("ems.test.env", true)) {
			//업로드 파일 리스트를 만든다.
			List<String> putList = new ArrayList<String>();
			for (int i=0; i<dsFile.size(); i++) {
				putList.add(propertiesService.getString("global.fileupload.path") + "/" +
						   (String)dsFile.get(i).get("fileUploadNm"));
			}
			
			//파일을 업로드 한다.
			int putCnt =FtpUtil.putList(propertiesService.getString("ems.ftp.hostName"),
										propertiesService.getInt("ems.ftp.port"), 
										propertiesService.getString("ems.ftp.userName"),
										propertiesService.getString("ems.ftp.userPwd"),
										putList, 
										propertiesService.getString("ems.ftp.mms.homeDir"));
			//업로드 갯수 검사
			if (putCnt != dsFile.size()) {
				return super.setResultSet(mav, DefaultConsts.ERR_CODE, messageService.getMessage("sc.cmn.mms.file.put.error"));
			}
		}
		
		//LMS/MMS 전송을(를) 등록 처리한다.
		int processCnt = lmsMmsSendService.saveLmsMms(lmsMmsList);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
