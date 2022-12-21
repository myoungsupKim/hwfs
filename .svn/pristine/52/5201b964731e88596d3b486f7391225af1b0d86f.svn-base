package com.hwfs.fs.fso.web;

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
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fs.fso.service.ObjectMngtCardService;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 물건관리카드하는 ObjectMngtCard Controller
 * 
 * @ClassName ObjectMngtCardController.java
 * @Description ObjectMngtCardController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최문규
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fso/objectMngtCard/")
public class ObjectMngtCardController extends DefaultController {
	
	/** ObjectMngtCardService Bean 생성 */
	@Resource(name = "/fs/fso/objectMngtCardService")
	private ObjectMngtCardService objectMngtCardService;
	
	/** File Attach Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	/**
	 * 물건관리카드 계약만료 팝업을 조회한다.
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
	@RequestMapping("selectObjectMngtCardRunOutList.xdo")
	public ModelAndView selectObjectMngtCardRunOutList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

// [속도개선 Project 시작] 2017. 7. 21. 최범주 사용자가 FS사업부일 경우 담당마케터 콤보 셋팅 기능 추가
		@SuppressWarnings("unchecked")
		Map<String, Object> ds_search = param.get("ds_search").get(0);
		String muCd                   = ds_search.get("muCd").toString();
		String tmCd                   = ds_search.get("tmCd").toString();
		String orgMuCd                = ds_search.get("orgMuCd").toString();
		String orgTmCd                = ds_search.get("orgTmCd").toString();
		String tgrYn                  = "N";
		RecordSet rs_tgrYn            = null;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// FS사업부일 경우 팀장여부 조회
		if ( ValidationUtil.isEquals(orgMuCd, "2002") ) {
			rs_tgrYn = objectMngtCardService.searchTgrYn(ds_search);
			
			if ( rs_tgrYn.getRowCount() > 0 ) {
				tgrYn = rs_tgrYn.get(0).getString("tgrYn");
			}
			ds_search.put("tgrYn", tgrYn);
		}
		
		//물건관리카드 을(를) 조회한다.
		RecordSet rs = objectMngtCardService.selectObjectMngtCardRunOutList(ds_search);
		
/* 2018.10.12 김명섭 조건 체크 주석처리
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 사업부가 FS사업부일 경우
		if ( ValidationUtil.isEquals(orgMuCd, "2002") ) {
			// 자신이 속한 팀이외는 리턴값 없음
			if ( !ValidationUtil.isEquals(tmCd, orgTmCd) ) {
				rs.clear();
			}
			
		// 사업부가 FS사업부가 아닐 경우
		} else {
			// 사업부를 FS사업부로 선택했을 경우
			if ( ValidationUtil.isEquals(muCd, "2002") ) {
				rs.clear();
			}
		}
2018.10.12 김명섭 조건 체크 주석처리 */
// [속도개선 Project   끝] 2017. 7. 21. 최범주

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_runOutList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 물건관리카드 등록대상 고객사팝업을 조회한다.
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
	@RequestMapping("selectObjectMngtCardRegPopup.xdo")
	public ModelAndView selectObjectMngtCardRegPopup(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//물건관리카드 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = objectMngtCardService.selectObjectMngtCardRegPopup(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		if("A".equals(param.get("ds_search").get(0).get("searchType"))) {
			super.addOutDataSet(mav, "ds_list", rs);
		}else {
			super.addOutDataSet(mav, "ds_list2", rs);
		}
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * Combo 코드목록을 조회한다.
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
	@SuppressWarnings("unchecked")
	@RequestMapping("selectCode.xdo")
	public ModelAndView selectCode(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//정산집계관리 을(를) 조회한다.
		Map<String, RecordSet> rs = objectMngtCardService.selectCode(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_searchPrcgEmp", rs.get("empCd"));
		super.addOutDataSet(mav, "ds_prcgEmp", rs.get("empCd"));
		super.addOutDataSet(mav, "ds_searchLocCd", rs.get("loc"));
		super.addOutDataSet(mav, "ds_locCd", rs.get("loc"));
		super.addOutDataSet(mav, "ds_jobCd", rs.get("job"));
		super.addOutDataSet(mav, "ds_opVendor", rs.get("opVendor"));
		super.addOutDataSet(mav, "ds_prcgDept", rs.get("dept"));
		
		super.addOutDataSet(mav, "ds_jobClassCd", rs.get("jobClass"));
		super.addOutDataSet(mav, "ds_jobMClassCd", rs.get("jobMClass"));
		super.addOutDataSet(mav, "ds_jobSClassCd", rs.get("jobSClass"));

		super.addOutDataSet(mav, "ds_locCd2", rs.get("loc2"));
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 물건목록을 조회한다.
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
	@RequestMapping("selectObjectList.xdo")
	public ModelAndView selectObjectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
// [속도개선 Project 시작] 2017. 7. 21. 최범주 사용자가 FS사업부일 경우 담당마케터 콤보 셋팅 기능 추가
		@SuppressWarnings("unchecked")
		Map<String, Object> ds_search = param.get("ds_search").get(0);
		String muCd                   = ds_search.get("muCd").toString();
		String tmCd                   = ds_search.get("tmCd").toString();
		String orgMuCd                = ds_search.get("orgMuCd").toString();
		String orgTmCd                = ds_search.get("orgTmCd").toString();
		String tgrYn                  = "N";
		RecordSet rs_tgrYn            = null;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// FS사업부일 경우 팀장여부 조회
		if ( ValidationUtil.isEquals(orgMuCd, "2002") ) {
			rs_tgrYn = objectMngtCardService.searchTgrYn(ds_search);
			
			if ( rs_tgrYn.getRowCount() > 0 ) {
				tgrYn = rs_tgrYn.get(0).getString("tgrYn");
			}
		}
		
		//물건관리카드 을(를) 조회한다.
		RecordSet rs = objectMngtCardService.selectObjectList(ds_search);

/* 2018.10.12 김명섭 조건 체크 주석처리
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 사업부가 FS사업부일 경우
		if ( ValidationUtil.isEquals(orgMuCd, "2002") ) {
			// 자신이 속한 팀이외는 리턴값 없음
			if ( !ValidationUtil.isEquals(tmCd, orgTmCd) ) {
				rs.clear();
			}
			
			// 팀원이면서 담당 마케터가 없을 경우 리턴값 없음
			if ( !ValidationUtil.isEquals(tgrYn, "Y") ) {
				if ( !ds_search.containsKey("prcgEmp") || ValidationUtil.isEmpty(ds_search.get("prcgEmp").toString()) ) {
					rs.clear();
				}
			}
			
		// 사업부가 FS사업부가 아닐 경우
		} else {
			// 사업부를 FS사업부로 선택했을 경우
			if ( ValidationUtil.isEquals(muCd, "2002") ) {
				rs.clear();
			}
		}
2018.10.12 김명섭 조건 체크 주석처리 */
// [속도개선 Project   끝] 2017. 7. 21. 최범주

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_objectList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 물건정보 상세를 조회한다.
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
	@RequestMapping("selectDetail.xdo")
	public ModelAndView selectDetail(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//물건관리카드 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		Map<String, RecordSet> rs = objectMngtCardService.selectDetail(param.get("ds_search").get(0));
		
		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (param.get("ds_search").size() > 0) {
			@SuppressWarnings("unchecked")
			Map<String, Object> map = param.get("ds_search").get(0);
			
		//	System.out.println(" @@@@@@@@@@[map.get(refSeq)]@@@@@@@@@@@ "+map.get("refSeq"));
			
			if (map.get("refSeq") != null)
				strRefSeq =  map.get("refSeq").toString();
		}
		
	//	System.out.println(" @@@@@@@@@@[strRefSeq]@@@@@@@@@@@ "+strRefSeq);
		
		//첨부파일 조회 Service 호출
		@SuppressWarnings("rawtypes")
		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_accObjectCard", rs.get("detail"));
		super.addOutDataSet(mav, "ds_accObjectMealUprice", rs.get("uprice"));
		super.addOutDataSet(mav, "ds_accObjectUpjang", rs.get("upjang"));
		super.addOutDataSet(mav, "ds_file", fileList);	//첨부파일 정보

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 로그인 사용자의 부서, 사번을 조회한다.
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
	@RequestMapping("selectEmpMarketer.xdo")
	public ModelAndView selectEmpMarketer(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//물건관리카드 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = objectMngtCardService.selectEmpMarketer(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_empMarketer", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 물건관리카드(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveObjectMngtCard.xdo")
	public ModelAndView saveObjectMngtCard(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap listObjMngtCard 	 = param.get("ds_accObjectCard");		// 물건관리 상세
		DataSetMap listObjMealUprice = param.get("ds_accObjectMealUprice");	// 식단가
		DataSetMap listObjectUpjang  = param.get("ds_accObjectUpjang");		// 업장정보
		DataSetMap listFile 		 = param.get("ds_file");	// 첨부파일 정보

		//물건관리카드을(를) 등록, 수정, 삭제 처리한다.
		String strRefSeq = objectMngtCardService.saveObjectMngtCard(listObjMngtCard,listObjMealUprice,listObjectUpjang,listFile, loginDTO.getSabun());
				
		//첨부파일 조회 Service 호출
		if (!strRefSeq.equals("") && (strRefSeq != null) && (!strRefSeq.isEmpty()) && (strRefSeq.length()>0)) {
			@SuppressWarnings("rawtypes")
			List<Map>fileList = attachFileService.selectList(strRefSeq);
			super.addOutDataSet (mav, "ds_file", fileList);
		}
		
		//(중요)클라이언트에 처리 정보를 전달 : 첨부참조일련번호
		super.addOutVariable(mav, "fv_refSeq", strRefSeq);
		//처리건수를 OutVariable에 설정한다.
		//super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 지역코드2를 조회한다.
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
	@RequestMapping("selectLocCd2.xdo")
	public ModelAndView selectLocCd2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//물건관리카드 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = objectMngtCardService.selectLocCd2(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_locCd2", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 지역코드2 전체를 조회한다.
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
	@RequestMapping("selectLocCd2All.xdo")
	public ModelAndView selectLocCd2All(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//물건관리카드 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = objectMngtCardService.selectLocCd2All(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_locCd2All", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
// [속도개선 Project 시작] 2017. 7. 21. 최범주 사용자가 FS사업부일 경우 담당마케터 콤보 셋팅 기능 추가
	/**
	 * 팀장여부 조회
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
	@RequestMapping("searchTgrYn.xdo")
	public ModelAndView searchTgrYn(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//물건관리카드 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = objectMngtCardService.searchTgrYn(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_tgrYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
// [속도개선 Project   끝] 2017. 7. 21. 최범주

	/**
	 * 조회용 지역코드2를 조회한다.
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
	@RequestMapping("selectSearchLocCd2.xdo")
	public ModelAndView selectSearchLocCd2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//물건관리카드 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = objectMngtCardService.selectSearchLocCd2(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_searchLocCd2", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("changeObjectMngtCard.xdo")
	public ModelAndView changeObjectMngtCard(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap listObjectList  = param.get("ds_objectList");

		//물건관리카드을(를) 수정한다.
		int processCnt = objectMngtCardService.chgangeObjectMngtCard(listObjectList);
				
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}


