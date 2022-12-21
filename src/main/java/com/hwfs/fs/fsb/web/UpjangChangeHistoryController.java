package com.hwfs.fs.fsb.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fs.fsb.service.UpjangChangeHistoryService;


 /**
 * 업장이력조회하는 UpjangChangeHistory Controller
 * 
 * @ClassName UpjangPackHistoryController.java
 * @Description UpjangPackHistoryController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최문규
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsb/upjangChangeHistory/")
public class UpjangChangeHistoryController extends DefaultController {
	
	/** UpjangPackHistoryService Bean 생성 */
	@Resource(name = "/fs/fsb/upjangChangeHistoryService")
	private UpjangChangeHistoryService upjangChangeHistoryService;
	
	/**
	 * 업장이력조회 목록을 조회한다.
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
	@RequestMapping("selectUpjangChangeHistory.xdo")
	public ModelAndView selectUpjangChangeHistory(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//업장이력조회 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		Map<String, RecordSet> rs = upjangChangeHistoryService.selectUpjangChangeHistory(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_accountingInfoHistory", rs.get("accountingInfo"));
		super.addOutDataSet(mav, "ds_opInfoHistory", rs.get("accountingInfo"));
		super.addOutDataSet(mav, "ds_contractInfoHistory", rs.get("accountingInfo"));
		super.addOutDataSet(mav, "ds_mpriceHistory", rs.get("mpriceInfo"));
		
		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수 
		accessLogService.readLog(param.get("ds_search").get(0), rs.get("accountingInfo").size());
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
}
