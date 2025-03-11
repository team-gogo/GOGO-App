import 'package:flutter/foundation.dart';

class SearchSchoolRowModel {
  final List<SearchSchoolResponse> row;

  SearchSchoolRowModel({required this.row});

  factory SearchSchoolRowModel.fromJson(Map<String, dynamic> json) {
    if (json['schoolInfo'] != null && json['schoolInfo'].length > 1) {
      List rowJson = json['schoolInfo'][1]['row'];
      List<SearchSchoolResponse> row =
          rowJson.map((e) => SearchSchoolResponse.fromJson(e)).toList();
      return SearchSchoolRowModel(row: row);
    } else {
      debugPrintThrottled('값이 없습니다');
      return SearchSchoolRowModel(row: []);
    }
  }
}

class SearchSchoolResponse {
  final String atptOfcdcScCode;
  final String atptOfcdcScNm;
  final String sdSchulCode;
  final String schulNm;
  final String engSchulNm;
  final String schulKndScNm;
  final String lctnScNm;
  final String juOrgNm;
  final String fondScNm;
  final String orgRdnzc;
  final String orgRdnma;
  final String orgRdnda;
  final String orgTelno;
  final String hmpgAdres;
  final String coeduScNm;
  final String orgFaxno;
  final String hsScNm;
  final String indstSpeclCccclExstYn;
  final String hsGnrlBusnsScNm;
  final String? spclyPurpsHsOrdNm;
  final String eneBfeSehfScNm;
  final String dghtScNm;
  final String fondYmd;
  final String foasMemrd;
  final String loadDtm;

  SearchSchoolResponse({
    required this.atptOfcdcScCode,
    required this.atptOfcdcScNm,
    required this.sdSchulCode,
    required this.schulNm,
    required this.engSchulNm,
    required this.schulKndScNm,
    required this.lctnScNm,
    required this.juOrgNm,
    required this.fondScNm,
    required this.orgRdnzc,
    required this.orgRdnma,
    required this.orgRdnda,
    required this.orgTelno,
    required this.hmpgAdres,
    required this.coeduScNm,
    required this.orgFaxno,
    required this.hsScNm,
    required this.indstSpeclCccclExstYn,
    required this.hsGnrlBusnsScNm,
    this.spclyPurpsHsOrdNm,
    required this.eneBfeSehfScNm,
    required this.dghtScNm,
    required this.fondYmd,
    required this.foasMemrd,
    required this.loadDtm,
  });

  factory SearchSchoolResponse.fromJson(Map<String, dynamic> json) {
    return SearchSchoolResponse(
      atptOfcdcScCode: json['ATPT_OFCDC_SC_CODE'] as String? ?? '',
      atptOfcdcScNm: json['ATPT_OFCDC_SC_NM'] as String? ?? '',
      sdSchulCode: json['SD_SCHUL_CODE'] as String? ?? '',
      schulNm: json['SCHUL_NM'] as String? ?? '',
      engSchulNm: json['ENG_SCHUL_NM'] as String? ?? '',
      schulKndScNm: json['SCHUL_KND_SC_NM'] as String? ?? '',
      lctnScNm: json['LCTN_SC_NM'] as String? ?? '',
      juOrgNm: json['JU_ORG_NM'] as String? ?? '',
      fondScNm: json['FOND_SC_NM'] as String? ?? '',
      orgRdnzc: json['ORG_RDNZC'] as String? ?? '',
      orgRdnma: json['ORG_RDNMA'] as String? ?? '',
      orgRdnda: json['ORG_RDNDA'] as String? ?? '',
      orgTelno: json['ORG_TELNO'] as String? ?? '',
      hmpgAdres: json['HMPG_ADRES'] as String? ?? '',
      coeduScNm: json['COEDU_SC_NM'] as String? ?? '',
      orgFaxno: json['ORG_FAXNO'] as String? ?? '',
      hsScNm: json['HS_SC_NM'] as String? ?? '',
      indstSpeclCccclExstYn: json['INDST_SPECL_CCCCL_EXST_YN'] as String? ?? '',
      hsGnrlBusnsScNm: json['HS_GNRL_BUSNS_SC_NM'] as String? ?? '',
      spclyPurpsHsOrdNm: json['SPCLY_PURPS_HS_ORD_NM'] as String?,
      eneBfeSehfScNm: json['ENE_BFE_SEHF_SC_NM'] as String? ?? '',
      dghtScNm: json['DGHT_SC_NM'] as String? ?? '',
      fondYmd: json['FOND_YMD'] as String? ?? '',
      foasMemrd: json['FOAS_MEMRD'] as String? ?? '',
      loadDtm: json['LOAD_DTM'] as String? ?? '',
    );
  }
}
