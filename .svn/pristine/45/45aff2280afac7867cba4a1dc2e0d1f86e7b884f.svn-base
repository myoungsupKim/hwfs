package com.hwfs.fs.fsa.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fs.fsa.service.AdoptionSmsListService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.SmsSendService;


 /**
 * 채용인력 sms발송하는 AdoptionSmsList Controller
 * 
 * @ClassName AdoptionSmsListController.java
 * @Description AdoptionSmsListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.15    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 김예진
 * @since 2015.04.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsa/adoptionSmsList/")
public class AdoptionSmsListController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdoptionSmsListService Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionSmsListService")
	private AdoptionSmsListService adoptionSmsListService;
	
	/**
	 * 채용인력 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
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
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//채용인력 을(를) 조회한다.
		RecordSet poolList = adoptionSmsListService.selectList(param.get("ds_search").get(0));
		RecordSet logList = adoptionSmsListService.selectSmslog(param.get("ds_search").get(0));
		
		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수 accessLogService.readLog(inVar, rs.size());
		accessLogService.readLog(param.get("ds_search").get(0), poolList.size());

		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수 accessLogService.readLog(inVar, rs.size());
		accessLogService.readLog(param.get("ds_search").get(0), logList.size());

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_pool", poolList);
		super.addOutDataSet(mav, "ds_smsLog", logList);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 채용인력(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameterSend = param.get("ds_sendList");
		DataSetMap parameterForm = param.get("ds_smsForm");
		
		//로그인 정보
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		
		//채용인력을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = adoptionSmsListService.saveList(parameterSend, parameterForm, loginDTO);
		
		//개인정보보호 접근로그를 쌓는다.
		accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"HP_NO"}));

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
