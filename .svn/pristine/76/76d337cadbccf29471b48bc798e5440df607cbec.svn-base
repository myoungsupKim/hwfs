package com.hwfs.fs.fsa.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fs.fsa.service.AdoptionPoolSearchPopService;
import com.hwfs.sc.cmn.service.AttachFileService;


 /**
 * 인력을 조회하는 AdoptionPoolSearchPop Controller
 * 
 * @ClassName AdoptionPoolSearchPopController.java
 * @Description AdoptionPoolSearchPopController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 김예진
 * @since 2015.04.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsa/adoptionPoolSearchPop/")
public class AdoptionPoolSearchPopController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AdoptionPoolSearchPopService Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionPoolSearchPopService")
	private AdoptionPoolSearchPopService adoptionPoolSearchPopService;
	
	/**
	 * 인력 목록을 조회한다.
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
		
		//인력을(를) 조회한다.
		RecordSet poolList = adoptionPoolSearchPopService.selectList(param.get("ds_search").get(0));

		//첨부파일 참조일련번호를 얻는다.
//		String strRefSeq = "";
//		if (poolList.size() > 0) {
//			Map map = poolList.get(0);
//			Map<String, Object> rowData = poolList.get(0);
//			if (rowData.get("fileId") != null)
//				strRefSeq =  rowData.get("fileId").toString(); //필드명이 "refSeq"인 경우임
//		}

		//개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수 accessLogService.readLog(inVar, rs.size());
		accessLogService.readLog(param.get("ds_search").get(0), poolList.size());
		
		//첨부파일 조회 Service 호출
//		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_pool", poolList);
//		super.addOutDataSet(mav, "ds_file", fileList);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
