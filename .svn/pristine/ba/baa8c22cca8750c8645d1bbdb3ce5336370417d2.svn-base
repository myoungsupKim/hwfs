package com.hwfs.sc.scc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.scc.service.MobileMsgSendService;
import com.tobesoft.xplatform.data.DataSet;


 /**
 * 모바일로 메시지를 전송하는 MobileMsgSend Controller
 * 
 * @ClassName MobileMsgSendController.java
 * @Description MobileMsgSendController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/mobileMsgSend/")
public class MobileMsgSendController extends DefaultController {
	
	/** MobileMsgSendService Bean 생성 */
	@Resource(name = "/sc/scc/mobileMsgSendService")
	private MobileMsgSendService mobileMsgSendService;
	
	/**
	 * 모바일 메시지 전송 목록을 조회한다.
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
		@SuppressWarnings("unchecked")
		Map <String, Object> inVar = param.get("ds_search").get(0);
		
		//모바일 메시지 전송 을(를) 조회한다.
		RecordSet rs = mobileMsgSendService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 모바일 메시지 전송(을)를 처리한다.
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
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		@SuppressWarnings("unchecked")
		Map <String, Object> mapMsg = param.get("ds_msg").get(0);
		DataSetMap list = param.get("ds_list");
		DataSetMap listUpjang = param.get("ds_listUpjang");

		//메시지를 json 현태로 변환 {"Loc":null,"StDt":null,"Body":"테스트","Title":"테스트","EnDt":null}
		JSONObject jsonMsg = new JSONObject ();
		jsonMsg.put("Loc", "");
		jsonMsg.put("StDt", "");
		jsonMsg.put("EnDt", "");
		jsonMsg.put("Title", mapMsg.get("subject"));
		jsonMsg.put("Body", mapMsg.get("msg"));
		
		//내부 부서 목록을 문자열로 변롼
		String strCc = "";
		
		boolean isFirst = true;
		for (int i=0; i< list.size(); i++) {
			int rowType = ((Integer)list.get(i).get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert, Update 건만 처리
			if (rowType == DataSet.ROW_TYPE_DELETED) continue;
			if (isFirst) isFirst=false; else strCc += ","; 
			strCc += "'" + list.get(i).get("ccCd") + "'";
			
		}

		//외부 업장 목록을 문자열로 변롼
		String strUpjang = "";
		isFirst = true;
		for (int i=0; i< listUpjang.size(); i++) {
			int rowType = ((Integer)listUpjang.get(i).get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Insert, Update 건만 처리
			if (rowType == DataSet.ROW_TYPE_DELETED) continue;
			if (isFirst) isFirst=false; else strUpjang += ","; 
			strUpjang += "'" + listUpjang.get(i).get("upjang") + "'";
		}
		
		//모바일 메시지 전송을(를) 처리한다.
		int processCnt = mobileMsgSendService.saveList(jsonMsg.toString(), strCc, strUpjang);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
