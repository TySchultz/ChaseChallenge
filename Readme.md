# Chase Coding Challenge 

###### Goal 

> Create an iOS app that provides information on NYC High schools. Display a list of NYC High Schools.

[Original Requirements PDF](./ChallengePDF.pdf)

##### Timeline 

Project Start: 9:00AM October 9th 

Project Finish: 3:30 PM October 9th 

Break: 1 hour 

##### CheckPoints 

- [x] A fully working prototype.
	- View all schools 
	- Search 
	- View detailed information and SAT scores 
- [x] Don’t worry about making the UI pretty.
- [x] Tech approach you took and why.
	- I decided to go with a simple two view structure. Main controller and detail controller. The main controller is built with IGListkit because of the speed and efficency that I can create using it. 
- [x] What was important to you – look and feel or the functionality?
	- They are both equally important to me. The app needs to be able to present the information clearly, and at the same time be able to retrieve information without delay. 
- [x] Unit test coverage.


## Outline 

- [Details](#details) 
- [Model](#model)
- [3rd Party](#3rdParty)
- [Architecture](#architecture)
- [UI](#UI)
- [Searching](#searching)
- [Helper Classes](#helperClasses)



## <a name="details"></a> Details 

#### UI Note:

Selecting a school should show additional information about the school. Display all the SAT scores - include Math, Reading and Writing.

#### School List Source API:
	
Get your data here - https://data.cityofnewyork.us/Education/DOE-High-School-Directory-2017/s3k6- pzi2

####  SAT Source API:
	
SAT data here - https://data.cityofnewyork.us/Education/SAT-Results/f9bf-2cp4


#### JSON Endpoints 

School List 

https://data.cityofnewyork.us/resource/97mf-9njv.json


```json 

//Example node 

[{
    "academicopportunities1": "Free college courses at neighboring universities",
    "academicopportunities2": "International Travel, Special Arts Programs, Music, Internships, College Mentoring English Language Learner Programs: English as a New Language",
    "admissionspriority11": "Priority to continuing 8th graders",
    "admissionspriority21": "Then to Manhattan students or residents",
    "admissionspriority31": "Then to New York City residents",
    "attendance_rate": "0.970000029",
    "bbl": "1008420034",
    "bin": "1089902",
    "boro": "M",
    "borough": "MANHATTAN",
    "building_code": "M868",
    "bus": "BM1, BM2, BM3, BM4, BxM10, BxM6, BxM7, BxM8, BxM9, M1, M101, M102, M103, M14A, M14D, M15, M15-SBS, M2, M20, M23, M3, M5, M7, M8, QM21, X1, X10, X10B, X12, X14, X17, X2, X27, X28, X37, X38, X42, X5, X63, X64, X68, X7, X9",
    "census_tract": "52",
    "city": "Manhattan",
    "code1": "M64A",
    "community_board": "5",
    "council_district": "2",
    "dbn": "02M260",
    "directions1": "See theclintonschool.net for more information.",
    "ell_programs": "English as a New Language",
    "extracurricular_activities": "CUNY College Now, Technology, Model UN, Student Government, School Leadership Team, Music, School Musical, National Honor Society, The Clinton Post (School Newspaper), Clinton Soup (Literary Magazine), GLSEN, Glee",
    "fax_number": "212-524-4365",
    "finalgrades": "6-12",
    "grade9geapplicants1": "1515",
    "grade9geapplicantsperseat1": "19",
    "grade9gefilledflag1": "Y",
    "grade9swdapplicants1": "138",
    "grade9swdapplicantsperseat1": "9",
    "grade9swdfilledflag1": "Y",
    "grades2018": "6-11",
    "interest1": "Humanities & Interdisciplinary",
    "latitude": "40.73653",
    "location": "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)",
    "longitude": "-73.9927",
    "method1": "Screened",
    "neighborhood": "Chelsea-Union Sq",
    "nta": "Hudson Yards-Chelsea-Flatiron-Union Square                                 ",
    "offer_rate1": "Â—57% of offers went to this group",
    "overview_paragraph": "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.",
    "pct_stu_enough_variety": "0.899999976",
    "pct_stu_safe": "0.970000029",
    "phone_number": "212-524-4360",
    "primary_address_line_1": "10 East 15th Street",
    "program1": "M.S. 260 Clinton School Writers & Artists",
    "requirement1_1": "Course Grades: English (87-100), Math (83-100), Social Studies (90-100), Science (88-100)",
    "requirement2_1": "Standardized Test Scores: English Language Arts (2.8-4.5), Math (2.8-4.5)",
    "requirement3_1": "Attendance and Punctuality",
    "requirement4_1": "Writing Exercise",
    "requirement5_1": "Group Interview (On-Site)",
    "school_10th_seats": "1",
    "school_accessibility_description": "1",
    "school_email": "admissions@theclintonschool.net",
    "school_name": "Clinton School Writers & Artists, M.S. 260",
    "school_sports": "Cross Country, Track and Field, Soccer, Flag Football, Basketball",
    "seats101": "YesÂ–9",
    "seats9ge1": "80",
    "seats9swd1": "16",
    "state_code": "NY",
    "subway": "1, 2, 3, F, M to 14th St - 6th Ave; 4, 5, L, Q to 14th St-Union Square; 6, N, R to 23rd St",
    "total_students": "376",
    "website": "www.theclintonschool.net",
    "zip": "10003"
},

```

SAT Results 

https://data.cityofnewyork.us/resource/734v-jeq5.json


```json
Example Node 

{
    "dbn": "01M450",
    "num_of_sat_test_takers": "70",
    "sat_critical_reading_avg_score": "377",
    "sat_math_avg_score": "402",
    "sat_writing_avg_score": "370",
    "school_name": "EAST SIDE COMMUNITY SCHOOL"
},

```


## <a name="model"></a> Model 

For the sake of this coding test we do not need to maintain all variables on this class node. We will only pull the ones we will need to use when displaying information or for relation to the SAT Scores. 

`dbn` will be used as the key relating the SAT scores to the Schools. 

__School Model__

```json 

//Example node 

[{
    "academicopportunities1": "Free college courses at neighboring universities",
    "academicopportunities2": "International Travel, Special Arts Programs, Music, Internships, College Mentoring English Language Learner Programs: English as a New Language",
    "attendance_rate": "0.970000029",
    "borough": "MANHATTAN",
    "city": "Manhattan",
    "dbn": "02M260",
    "extracurricular_activities": "CUNY College Now, Technology, Model UN, Student Government, School Leadership Team, Music, School Musical, National Honor Society, The Clinton Post (School Newspaper), Clinton Soup (Literary Magazine), GLSEN, Glee",
    "latitude": "40.73653",
    "location": "10 East 15th Street, Manhattan NY 10003 (40.736526, -73.992727)",
    "longitude": "-73.9927",
    "neighborhood": "Chelsea-Union Sq",
    "overview_paragraph": "Students who are prepared for college must have an education that encourages them to take risks as they produce and perform. Our college preparatory curriculum develops writers and has built a tight-knit community. Our school develops students who can think analytically and write creatively. Our arts programming builds on our 25 years of experience in visual, performing arts and music on a middle school level. We partner with New Audience and the Whitney Museum as cultural partners. We are a International Baccalaureate (IB) candidate school that offers opportunities to take college courses at neighboring universities.",
    "phone_number": "212-524-4360",
    "primary_address_line_1": "10 East 15th Street",
    "school_email": "admissions@theclintonschool.net",
    "school_name": "Clinton School Writers & Artists, M.S. 260",
    "school_sports": "Cross Country, Track and Field, Soccer, Flag Football, Basketball",
    "state_code": "NY",
    "subway": "1, 2, 3, F, M to 14th St - 6th Ave; 4, 5, L, Q to 14th St-Union Square; 6, N, R to 23rd St",
    "total_students": "376",
    "website": "www.theclintonschool.net",
    "zip": "10003"
},

```

Stripping the entire JSON down to these variables should give us more than enough information to display what is relevant and have a working app. 


```swift 

struct School: Codable, Equatable {
  //Main info
    let academicopportunities1: String
    let academicopportunities2: String
    let attendance_rate: String
    let borough: String
    
    let city: String
    let extracurricular_activities: String
    let dbn: String

    let latitude: String
    let location: String
    let longitude: String
    let neighborhood: String
    
    let overview_paragraph: String
    let phone_number: String
    let primary_address_line_1: String
    let school_email: String
    let school_name: String
	 let school_sports: String
	 let state_code: String
	 let subway: String
	 let total_students: String
	 let website: String
	 let zip: String

}

```

__SAT Model__


The SAT Model does not need to strip down the JSON at all. For the most part we need all of these properties. 



```json

Example Node 

{
    "dbn": "01M450",
    "num_of_sat_test_takers": "70",
    "sat_critical_reading_avg_score": "377",
    "sat_math_avg_score": "402",
    "sat_writing_avg_score": "370",
    "school_name": "EAST SIDE COMMUNITY SCHOOL"
},

```

## <a name="3rdParty"></a> 3rd Party 

    pod 'AlamofireNetworkActivityIndicator', '~> 2.1'
    pod 'Alamofire', '~> 4.7'
    pod 'SnapKit', '~> 4.0.0'
    
    # prerelease pods
    pod 'IGListKit/Swift', :git => 'https://github.com/Instagram/IGListKit.git', :branch => 'swift'
    pod 'StyledTextKit', :git => 'https://github.com/GitHawkApp/StyledTextKit.git', :branch => 'master'

- Alamofire
	- Dealing with networking and JSON endpoints 

- SnapKit 
	- UI creation and autolayout 

- IGListKit
	- Fast and efficent way of displaying lists 

- StyledTextKit
	- Managed Fonts 


## <a name="architecture"></a> Architecture 

We will have two screens. The Main tableview which is where the user lands initally will have a list of the schools. When the user taps on a school it will go to a detail tableview that will display the SAT scores as well as more information about the school. 


## <a name="UI"></a> UI 
![AirBnb](./AirBnb.png)

We will use AirBnb as a base to start from. They are doing essentially the same thing we are. Providing a list of locations with information that the user is looking for.

When the user taps on a `home` they display more information about that home. 

When looking at AirBnb search page they have 4 pieces of information along with an image. Going from this we will remove the picture and have 4 pieces of information. 

Our most important information 

- Borough 
- School Name 
- Primary Location 
- Phone Number 

Borough is the most important indicator to quickly know where the school is located. Because they are likely all in the same city. 

Becasue this is an easily filterable property we will have it in a different color.  


## <a name="searching"></a> Searching 

We will use a custom class caleld `Filterable` for when we are searching the schools. This class was adapted from `GitHawk` and open source app. 

We will search on three properties; school_name, city, borough. These three are the most relevant and wont display misleading results when searching. 

```swift 
extension School: Filterable {
    func match(query: String) -> Bool {
        let lowerQuery = query.lowercased()
        
        if school_name.contains(lowerQuery) { return true }
        if city.contains(lowerQuery) { return true }
        if borough.contains(lowerQuery) { return true }
        
        return false
    }
}
``` 


## <a name="helperClasses"></a> Helper Classes 

There is a folder containing a few classes that I use to help my workflow and move efficently. These classes were adapted from both personal work on `Akta Digets` as well as from `Githawk` a 3rd party open source app. 

