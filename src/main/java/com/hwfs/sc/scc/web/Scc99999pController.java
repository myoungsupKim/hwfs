package com.hwfs.sc.scc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.scc.service.Scc99999pService;

/**
 * Scc99999pController에 대한 설명 작성
 *
 * @ClassName Scc99999pController.java
 * @Description Scc99999pController Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 13.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 3. 13.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/scc99999p/")
public class Scc99999pController extends DefaultController {

	@Resource(name = "/sc/scc/Scc99999pService")
	private Scc99999pService scc99999pService;

	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	/**
	 * 단일 건과 첨부파일 select 문이 수행되는 서비스이다.
	 * @param xpDTO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "selectAttachFile.xdo")
	public ModelAndView selectAttachFile(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = inVar.get("fileRefSeq").toString();

		//첨부파일 조회 Service 호출
		List<Map> sampleFileList = attachFileService.selectList(strRefSeq);

		//조회결과를 전달할 DataSet 설정
		addOutDataSet (mav, "ds_file", sampleFileList);	//첨부파일 정보

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * DataSet의 rowType별로 Insert, Update, Delete가 수행되는 서비스이다.
	 *
	 * <pre>
	 * -데이터와 첨부파일을 함께 처리한다.
	 * -첨부파일은 파일 저장소에 저장한다.
	 * </pre>
	 *
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "saveAttachFile.xdo")
	public ModelAndView saveSampleAttachFile(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,
			HttpServletRequest req) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		Map<String, DataSetMap> inDataset = xpDTO.getInDataSetMap();

		// Service호출에 전달할 DataSetMap을 얻는다.
		DataSetMap listFile = (DataSetMap) inDataset.get("ds_file"); // 첨부파일 정보

		// 로그인 세션 정보 얻기
		// LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		// 서비스 호출 후 첨부참조일련번호가 반환된다.
		String strRefSeq = scc99999pService.saveAttachFile(listFile);

		// (중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		addOutVariable(mav, "fv_RefSeq", strRefSeq);

		// (중요)첨부파일정보가 바뀌므로 재조회 하여 클라이언트에 전달한다.
		// 첨부파일 조회 Service 호출
		if (!"".equals(strRefSeq)) {
			List<Map> fileList = attachFileService.selectList(strRefSeq);
			addOutDataSet(mav, "ds_file", fileList);
		}

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 테스트를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectTestList.xdo")
	public ModelAndView selectTestList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs1 = scc99999pService.selectPlTestList(parameter);
		RecordSet rs2 = scc99999pService.selectPiTestList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_pl_test_list", rs1);
		super.addOutDataSet(mav, "ds_pi_test_list", rs2);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
