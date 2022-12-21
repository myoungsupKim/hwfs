package com.hwfs.sc.scz.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.scc.service.ParameterLogService;
import com.hwfs.sc.scz.service.UpjangBatchRegService;


 /**
 * 업장을 일괄등록하는 UpjangBatchReg Controller
 *
 * @ClassName UpjangBatchRegController.java
 * @Description UpjangBatchRegController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.07.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/upjangBatchReg/")
public class UpjangBatchRegController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangBatchRegService Bean 생성 */
	@Resource(name = "/sc/scz/upjangBatchRegService")
	private UpjangBatchRegService upjangBatchRegService;

	@Resource(name="/sc/scc/parameterLogService")
	private ParameterLogService parameterLog;
	
	/**
	 * 업장 일괄등록 목록을 조회한다.
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
	@RequestMapping("selectDataValidation.xdo")
	public ModelAndView selectDataValidation(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장일괄등록(selectDataValidation)", parameter);
		
		//업장 일괄등록 을(를) 조회한다.
		List<Map<String, Object>> validData = upjangBatchRegService.selectDataValidation(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", validData);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장 일괄등록(을)를 Insert/Update/Delete 처리한다.
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장일괄등록(saveList-parameter)", parameter);
		parameterLog.setLog(logKey, "업장일괄등록(saveList-inVar)", inVar.toString());
		
		//업장 일괄등록을(를) 등록, 수정, 삭제 처리한다.
		List<Map<String, Object>> data = upjangBatchRegService.saveList(parameter, inVar);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "ds_list", data);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
