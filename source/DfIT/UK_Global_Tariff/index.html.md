---
title: UK Global Tariff
weight: 10
---

# DfIT: UK Global Tariff

## Endpoint URL:
 - [https://www.check-future-uk-trade-tariffs.service.gov.uk/](https://www.check-future-uk-trade-tariffs.service.gov.uk/)

## Documentation URL:
 - [https://data.gov.uk/dataset/19890572-14b6-4d37-8a6d-6a5ec3b457fe/tariffs-to-trade-with-the-uk-from-1-january-2021](https://data.gov.uk/dataset/19890572-14b6-4d37-8a6d-6a5ec3b457fe/tariffs-to-trade-with-the-uk-from-1-january-2021)

## Description:
The UK Global Tariff (UKGT) is the UK's first independent tariff policy which will replace the current Common External Tariff (CET) which applies until 31 December 2020. This tariff will enter into force on 1 January 2021. The UKGT will apply to all goods imported into the UK, unless an exception applies (such as a relief or tariff suspension), the goods come from countries that are part of the Generalised Scheme of Preferences, or the country importing from has a trade agreement with the UK. It only shows the tariffs that will be applied to goods at the border when they’re imported into the UK. It does not cover other import duties (such as VAT), the precise details of trade remedies measures, or other restrictions on imports, such as anti-dumping, countervailing or safeguards. For more information, see https://www.gov.uk/guidance/uk-tariffs-from-1-january-2021. 

This API lists how the tariff will change in the UKGT compared to the CET, split out by commodity code as specified to 8 or 10 digits by the 2020 Combined Nomenclature (CN). It includes a description for each code based on that standard. For each code, it includes the current duty expression under the CET and the new duty expression under the UKGT, with an additional field categorising the change (as 'no change', 'currency conversion', 'simplified', 'reduced' or 'liberalised'). The dataset also indicates where commodities are subject to a trade remedy, anti-dumping measure or suspension, or include an Autonomous Tariff Quota. Please see the guidance page for information on these terms and how the duty will change in these cases.

You can use this data when you need to make a calculation against the new third country duties that will apply in the UK from 1 January 2021, or to understand the difference between the new duty and the existing EU third country duty. You cannot use this data to calculate the total cost of a future import because it does not include rates that apply for preferential tariffs, quotas, trade remedies, suspensions or other measures. You also cannot use this data to understand the commodity code hierarchy, because not all codes are present and some descriptions have been modified to make sense out of context and are not legally binding.

API calls can be made using a GET request to 'https://check-future-uk-trade-tariffs.service.gov.uk/api/global-uk-tariff{format}' where **format** is:
- blank for JSON format
- '.csv' for Comma Separated Variables format
- '.xlsx' for Excel Spreadsheet format

The API accepts the following optional URL query parameters:
- 'q' accepts a string, and will filter the results for commodities where any field contains that string. Separate words can appear anywhere, so that a search for 'salmon trout' will only return commodities containing both 'salmon' and 'trout' without them having to be next to each other, or even in the same field.

Example: 'https://www.check-future-uk-trade-tariffs.service.gov.uk/api/global-uk-tariff?q=0301+trout'

