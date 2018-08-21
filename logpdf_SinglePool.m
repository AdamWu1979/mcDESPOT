function lnP = logpdf_SinglePool(x, Lower, Upper, FA_SPGR, FA_SSFP0, FA_SSFP180, TR_SPGR, TR_SSFP, Data, Sigma)

if any(x < Lower) || any(x > Upper)
  lnP = -inf;
  return
end

[Mss_SPGR, Mss_SSFP0, Mss_SSFP180] = MEX_mcDESPOT_SP(x(1), x(3), x(2), TR_SPGR, TR_SSFP, 0, rad2deg(FA_SPGR), rad2deg(FA_SSFP0), rad2deg(FA_SSFP180));

Mss_SSFP = [Mss_SSFP0 , Mss_SSFP180];

Data_SPGR = Data(1:numel(Mss_SPGR));
Data_SSFP = Data(numel(Mss_SPGR)+1:end);

Sig = [Mss_SPGR, Mss_SSFP]';
Data = [Data_SPGR; Data_SSFP];

lnP = -(sum((Sig - Data).^2))./(2*Sigma^2);

end

%Data_SPGR = (Data_SPGR * mean(Mss_SPGR))./mean(Data_SPGR);
%Data_SSFP = (Data_SSFP * mean(Mss_SSFP))./mean(Data_SSFP);