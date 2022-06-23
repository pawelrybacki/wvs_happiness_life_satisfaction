
cd "your_directory"

use "your_directory/F00008389-WVS_Longitudinal_1981_2016_stata_v20180912/WVS_Longitudinal_1981_2016_stata_v20180912.dta", clear

keep countrycode S002 S003 S007 S020 A001 A002 A003 A004 A005 A006 A007 A008 A009 A062 A098 A099 A100 A101 A102 A103 A104 A105 A106 A165 A168A A170 A173 A189 A190 A191 A192 A193 A194 A195 A196 A197 A198 A199 B018 B019 B020 C006 C008 C033 D002 E188 F001 F003 F022 F028 F028B F029 F034 F050 F051 F053 F054 F063 X001 X003 X007 X011 X028 X047

* remove negative values
mvdecode * , mv(-5 = .\-4 = .\-3 = .\-2 = .\-1 = .)

save wvs_life_satisfaction_temp, replace

use wvs_life_satisfaction_temp, clear

**************************************************************** renaming

* survey information
rename S020 year
rename S002 wave
rename S003 country_name
label var country_name "country"
rename S007 id

* basic descriptors
rename X001 sex
rename X003 age
rename X007 marital_status
rename X011 number_of_children
rename X028 employment_status
rename X047 scale_incomes

/* Note: sex and marital_status, employment_status had to be adjusted; age, number of children, scale_incomes were OK */

* environment
rename B018 environment_water
rename B019 environment_air
rename B020 environment_sanitation_sewage

* family
rename D002 home_life_satisfaction
* home_life_satisfaction is 1-10, from lowest to highest, which is fine 

* job
rename C006 financial_satisfaction
* financial_satisfaction is 1-10, from lowest to highest, which is fine 
rename C008 work_leisure
/* has to be adjusted */ 
rename C033 job_satisfaction
* job_satisfaction is 1-10, from lowest to highest, which is fine 

* habits
rename E188 watches_tv
* take more than 3 hours per day
rename A062 discusses_politics
* 3 levels, divide into 2 vars

* attitudes
rename A170 life_satisfaction
label var life_satisfaction "life satisfaction"
* life_satisfaction is 1-10, from lowest to highest, which is fine 
rename A165 trust
* needs to be adjusted
rename A168A most_people_try_to_be_fair
* most_people_try_to_be_fair is 1-10, from lowest to highest, which is fine 
rename A173 freedom_choice_control
* freedom_choice_control is 1-10, from lowest to highest, which is fine 
rename A008 feeling_of_happiness
* needs to be adjusted
rename A009 state_of_health
* needs to be adjusted

* religion and morality
rename F001 thinking_about_purpose_life
* adjustment 
rename F003 thinking_about_death
* adjustment 
rename F022 good_evil
* adjustment 
rename F028 attend_church
* adjustment
rename F028B pray
* adjustment
rename F029 raised_religiously
 tab attend_church
rename F034 religious_person
* adjustment
rename F050 believe_god
* binary, fine
rename F051 life_after_death
* binary, fine
rename F053 believe_hell
* binary, fine
rename F054 believe_heaven
* binary, fine
rename F063 god_important
* 1-10, from lowest to highest, which is fine 

* important in life
rename A001 important_family
rename A002 important_friends
rename A003 important_leisure
rename A004 important_politics
rename A005 important_work
rename A006 important_religion
rename A007 important_service_to_others

* Schwartz questions
* adjust all at once
rename A189 schwartz_ideas_creative
rename A190 schwartz_rich
rename A191 schwartz_secure_surroundings
rename A192 schwartz_good_time
rename A193 schwartz_help_nearby
rename A194 schwartz_successful
rename A195 schwartz_adventure_risks
rename A196 schwartz_behave_properly
rename A197 schwartz_environment
rename A198 schwartz_tradition
rename A199 schwartz_do_good_society

* activities 
rename A098 active_church
rename A099 active_sport
rename A100 active_art_music_edu
rename A101 active_labor_union 
rename A102 active_political_party 
rename A103 active_environment 
rename A104 active_professional_org
rename A105 active_charity
rename A106 active_other
drop active_other

**************************************************************** cleaning

*** basic descriptors

*** sex
rename sex male
replace male = 0 if male == 2

*** age
gen age_13_24 = .
replace age_13_24 = 0
replace age_13_24 = 1 if age < 25
gen age_25_40 = .
replace age_25_40 = 0
replace age_25_40 = 1 if age >= 25 & age < 41
gen age_41_60 = . 
replace age_41_60 = 0
replace age_41_60 = 1 if age >= 41 & age  < 61
gen age_61_80 = .
replace age_61_80 = 0
replace age_61_80 = 1 if age >= 61 & age < 81
gen age_81_more = .
replace age_81_more = 0
replace age_81_more = 1 if age >= 81
drop age

*** marital status
replace marital_status = . if marital_status == 7
gen married = .
replace married = 0 if marital_status != .
replace married = 1 if marital_status == 1
gen living_together_as_maried = .
replace living_together_as_maried = 0 if marital_status != .
replace living_together_as_maried = 1 if marital_status == 2
gen divorced = .
replace divorced = 0 if marital_status != .
replace divorced = 1 if marital_status == 3
gen separated = .
replace separated = 0 if marital_status != .
replace separated = 1 if marital_status == 4
gen widowed = .
replace widowed = 0 if marital_status != .
replace widowed = 1 if marital_status == 5
drop marital_status

*** employment
replace employment_status = . if employment_status == 8
/* Let's comment out the baseline
gen full_time = .
replace full_time = 0 if employment_status != .
replace full_time = 1 if employment_status == 1
*/

gen part_time = .
replace part_time = 0 if employment_status != .
replace part_time = 1 if employment_status == 2

gen self_employed = .
replace self_employed = 0 if employment_status != .
replace self_employed = 1 if employment_status == 3

gen retired = .
replace retired = 0 if employment_status != .
replace retired = 1 if employment_status == 4

gen housewife = .
replace housewife = 0 if employment_status != .
replace housewife = 1 if employment_status == 5

gen student = .
replace student = 0 if employment_status != .
replace student = 1 if employment_status == 6

gen unemployed = .
replace unemployed = 0 if employment_status != .
replace unemployed = 1 if employment_status == 7
drop employment_status


*** important in life
gen very_important_family = .
gen very_important_friends = .
gen very_important_leisure = .
gen very_important_politics = .
gen very_important_work = .
gen very_important_religion = .
gen very_important_service_to_others = .

replace very_important_family = 1 if important_family == 1
replace very_important_friends = 1 if important_friends == 1
replace very_important_leisure = 1 if important_leisure == 1
replace very_important_politics = 1 if important_politics == 1
replace very_important_work = 1 if important_work == 1
replace very_important_religion = 1 if important_religion == 1
replace very_important_service_to_others = 1 if important_service_to_others == 1

replace very_important_family = 0 if important_family == 2 | important_family == 3 | important_family == 4
replace very_important_friends = 0 if important_friends == 2 | very_important_friends == 3 | very_important_friends == 4
replace very_important_leisure = 0 if important_leisure == 2 | very_important_leisure == 3 | very_important_leisure == 4
replace very_important_politics = 0 if important_politics == 2 | very_important_politics == 3 | very_important_politics == 4
replace very_important_work = 0 if important_work == 2 | very_important_work == 3 | very_important_work == 4
replace very_important_religion = 0 if important_religion == 2 | very_important_religion == 3 | very_important_religion == 4
replace very_important_service_to_others = 0 if important_service_to_others == 2 | very_important_service_to_others == 3 | very_important_service_to_others == 4

drop important_family important_friends important_leisure important_politics important_work important_religion important_service_to_others

*** environment
/* Idea: if any of the environmental is somewhat serious or very serious, environment_problems gets 1; otherwise, environment_problems gets 0. */

gen environment_problems = .
replace environment_problems = 0 if environment_water != . | environment_air != . | environment_sanitation_sewage != .
replace environment_problems = 1 if environment_water == 1 | environment_water == 2 | environment_air == 1 | environment_air == 2 | environment_sanitation_sewage == 1 | environment_sanitation_sewage == 2
drop environment_water environment_air environment_sanitation_sewage

*** job 
/* Idea: you prefer leisure if you are 1-2 in the scale; you prefer work if you are 4-5 in the scale; you are baseline if you have no preference, so if you are 3 in the scale. */
gen prefer_leisure = .
replace prefer_leisure = 0 if work_leisure != .
replace prefer_leisure = 1 if work_leisure == 1 | work_leisure == 2

gen prefer_work = .
replace prefer_work = 0 if work_leisure != .
replace prefer_work = 1 if work_leisure == 4 | work_leisure == 5

drop work_leisure

*** habits
gen watches_tv_3_hours = . 
replace watches_tv_3_hours = 0 if watches_tv != .
replace watches_tv_3_hours = 1 if watches_tv == 4
drop watches_tv

gen discusses_politics_frequently = .
replace discusses_politics_frequently = 0 if discusses_politics != .
replace discusses_politics_frequently = 1 if discusses_politics == 1

gen discusses_politics_never = .
replace discusses_politics_never = 0 if discusses_politics != .
replace discusses_politics_never = 1 if discusses_politics == 3

drop discusses_politics

*** attitudes
replace trust = 0 if trust == 2

/* idea for happiness and health: the higher the better */
gen happiness = .
replace happiness = 0 if feeling_of_happiness == 4
replace happiness = 1 if feeling_of_happiness == 3
replace happiness = 2 if feeling_of_happiness == 2
replace happiness = 3 if feeling_of_happiness == 1
drop feeling_of_happiness

gen health = .
replace health = 0 if state_of_health == 5
replace health = 1 if state_of_health == 4
replace health = 2 if state_of_health == 3
replace health = 4 if state_of_health == 2
replace health = 5 if state_of_health == 1
drop state_of_health

*** religion and morality
gen thinks_about_purpose_life = .
replace thinks_about_purpose_life = 0 if thinking_about_purpose_life == 4
replace thinks_about_purpose_life = 1 if thinking_about_purpose_life == 3
replace thinks_about_purpose_life = 2 if thinking_about_purpose_life == 2
replace thinks_about_purpose_life = 4 if thinking_about_purpose_life == 1
drop thinking_about_purpose_life

gen thinks_about_death = .
replace thinks_about_death = 0 if thinking_about_death == 4
replace thinks_about_death = 1 if thinking_about_death == 3
replace thinks_about_death = 2 if thinking_about_death == 2
replace thinks_about_death = 4 if thinking_about_death == 1
drop thinking_about_death

gen clear_guidelines_good_evil = .
replace clear_guidelines_good_evil = 0 if good_evil != .
replace clear_guidelines_good_evil = 1 if  good_evil == 1

/* Idea: often means once a week or more than once a week */
gen attend_church_often = .
replace attend_church_often = 0 if attend_church != .
replace attend_church_often = 1 if attend_church == 1 | attend_church == 2
drop attend_church

/* Idea: often means at least several times each week rather than only when attending religious services or less often */
gen pray_often = .
replace pray_often = 0 if pray != .
replace pray_often = 1 if pray == 1 | pray == 2 | pray == 3
drop pray

/* Idea: create a religious person and a convinced atheist variables, while "not a religious person" is the baseline */

gen religious = .
replace religious = 0 if religious_person != .
replace religious = 1 if religious_person == 1

gen atheist = .
replace atheist = 0 if religious_person != .
replace atheist = 1 if religious_person == 3

drop religious_person

*** Schwartz questions
unab schwartz: schwartz*
foreach i in `schwartz' {
	gen `i'_bin = .
	replace `i'_bin = 0 if  `i' != .
	replace  `i'_bin = 1 if  `i' == 1 | `i' == 2
	drop `i'
}

*** active questions
unab active: active*
foreach i in `active' {
	gen `i'_bin = .
	replace `i'_bin = 0 if  `i' != .
	replace  `i'_bin = 1 if  `i' == 2
	drop `i'
}

*** Standardize variables into a 0-1 scale 
* https://www.stata.com/statalist/archive/2002-07/msg00345.html

local standardize financial_satisfaction scale_incomes freedom_choice_control health god_important thinks_about_purpose_life


	foreach var in `standardize' {
		qui sum `var'
		replace `var' = (`var' - `r(min)') / (`r(max)'-`r(min)')
	}
	
*** Recode life_satisfaction and happiness to dummies, for logit models
rename happiness happiness_factor
gen happiness = .
replace happiness = 0 if happiness_factor != .
replace happiness = 1 if happiness_factor == 3 | happiness_factor == 2

rename life_satisfaction life_satisfaction_factor
gen life_satisfaction = .
replace life_satisfaction = 0 if life_satisfaction_factor != .
replace life_satisfaction = 1 if life_satisfaction_factor > 5

*** Order and select variables

order id wave year country_name countrycode male age_13_24 age_25_40 age_41_60 age_61_80 age_81_more married living_together_as_maried divorced separated widowed number_of_children part_time self_employed unemployed retired housewife student financial_satisfaction scale_incomes health environment_problems religious atheist believe_god believe_hell believe_heaven life_after_death god_important raised_religiously attend_church attend_church_often pray pray_often good_evil clear_guidelines_good_evil thinks_about_purpose_life thinks_about_death prefer_leisure prefer_work watches_tv_3_hours discusses_politics_frequently discusses_politics_never *important* schwartz* active* trust most_people_try_to_be_fair freedom_choice_control job_satisfaction home_life_satisfaction happiness happiness_factor  life_satisfaction life_satisfaction_factor

keep id wave year country_name countrycode life_satisfaction happiness male age_13_24 age_25_40 age_41_60 age_61_80 age_81_more married living_together_as_maried divorced separated widowed number_of_children financial_satisfaction scale_incomes part_time self_employed retired housewife student unemployed trust freedom_choice_control health thinks_about_purpose_life god_important religious atheist attend_church discusses_politics_never discusses_politics_frequently environment_problems watches_tv_3_hours

save wvs_life_satisfaction, replace
erase wvs_life_satisfaction_temp.dta

