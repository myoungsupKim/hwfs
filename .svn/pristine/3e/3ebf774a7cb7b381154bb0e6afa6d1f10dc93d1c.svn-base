package com.hwfs.guide.sample.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.guide.sample.service.GuideEncService;

 /**
 * 개인정보보호 항목에 대한 암복호 처리 및 마스킹 처리 샘플 Controller
 * @ClassName GuideEncController.java
 * @Description GuideEncController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.02.12.   kksoo        최초작성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/guide/sample/guideEnc/")
public class GuideEncController extends DefaultController {
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** GuideEnc Service */
	@Resource(name="/guide/sample/guideEncService")
	private GuideEncService guideEncService;
	
	/**
	 * 개인정보보호 항목을 개인정보처리등급에 따라 마스크하여 조회한다.
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectMaskList.xdo")
	public ModelAndView selectMaskList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		RecordSet rs = guideEncService.selectMaskList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 비밀번호를 제외한 개인정보보호 항목을 입력을 위한 경우에는 복호화하여 조회한다.
	 *
	 * @param xpDTO
	 * @return
	 */
	@ValidationToken
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		RecordSet rs = guideEncService.selectList(inVar);

	    //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
	    accessLogService.readLog(inVar, rs.size());

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 개인정보보호 항목을 저장합니다.
	 *
	 * @param xpDTO
	 * @return
	 */
	@ValidationToken
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//개인정보보호 접근로그를 쌓는다.
	    accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"HP_NO, EMAIL"}));

		int processCnt = guideEncService.saveList(parameter);

		//XPlatform으로 넘겨줄 Out Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
