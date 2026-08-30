import 'package:sqlite3/sqlite3.dart';

void main() {
  const dbPath = 'assets/db/distributors.db';
  final db = sqlite3.open(dbPath);

  final String now = DateTime.now().toIso8601String();

  final salesPersonnelList = [
    // Page 2 (SL 1 to 35)
    {
      "id": 1,
      "name": "Khondokar Mahafuzul Haque",
      "designation": "Senior RSM",
      "mobile": "01712645685",
    },
    {
      "id": 2,
      "name": "Md. Shohel Rana",
      "designation": "RSM",
      "mobile": "01864193156",
    },
    {
      "id": 3,
      "name": "K M Motaher Hossain",
      "designation": "RSM",
      "mobile": "01716529428",
    },
    {
      "id": 4,
      "name": "Saikat Barua",
      "designation": "Senior Area Sales Manager",
      "mobile": "01829315505",
    },
    {
      "id": 5,
      "name": "Milon Mia",
      "designation": "Area Sales Manager",
      "mobile": "01713241668",
    },
    {
      "id": 6,
      "name": "Abdul Hamid Sharker",
      "designation": "Area Sales Manager",
      "mobile": "01712 808526",
    },
    {
      "id": 7,
      "name": "Md. Asahaque Ali",
      "designation": "Junior Area Sales Manager",
      "mobile": "01767295829",
    },
    {
      "id": 8,
      "name": "Rahat Khandakar",
      "designation": "Junior Area Sales Manager",
      "mobile": "01704571471",
    },
    {
      "id": 9,
      "name": "Md. Masum Rana",
      "designation": "Junior Area Sales Manager",
      "mobile": "01766166811",
    },
    {
      "id": 10,
      "name": "Dr. Tanvir Sayed",
      "designation": "Junior Area Sales Manager",
      "mobile": "01757081261",
    },
    {
      "id": 11,
      "name": "Topon Chandra Sorma",
      "designation": "Junior Area Sales Manager",
      "mobile": "01767673117",
    },
    {
      "id": 12,
      "name": "Parimal Chandra Sarker",
      "designation": "Junior Area Sales Manager",
      "mobile": "01517136160",
    },
    {
      "id": 13,
      "name": "Md. Mithun Hossain",
      "designation": "Junior Area Sales Manager",
      "mobile": "01758993948",
    },
    {
      "id": 14,
      "name": "A K M Ashiqur Rahman",
      "designation": "Senior Territory Manager",
      "mobile": "01788726946",
    },
    {
      "id": 15,
      "name": "Md. Lalon Hasan",
      "designation": "Senior Territory Manager",
      "mobile": "01719409484",
    },
    {
      "id": 16,
      "name": "Md. Azizul Hoque",
      "designation": "Senior Territory Manager",
      "mobile": "01742138773",
    },
    {
      "id": 17,
      "name": "Md Sumon Rana",
      "designation": "Senior Territory Manager",
      "mobile": "01735941517",
    },
    {
      "id": 18,
      "name": "Md. Rasel Howlader",
      "designation": "Senior Territory Manager",
      "mobile": "01724770901",
    },
    {
      "id": 19,
      "name": "Foni Ranjan Sarker",
      "designation": "Territory Manager",
      "mobile": "01910012221",
    },
    {
      "id": 20,
      "name": "Azanur Rahman",
      "designation": "Territory Manager",
      "mobile": "01766330866",
    },
    {
      "id": 21,
      "name": "Md Hasanul Haque Prokash",
      "designation": "Territory Manager",
      "mobile": "01881989590",
    },
    {
      "id": 22,
      "name": "Md. Malekin Nasir",
      "designation": "Territory Manager",
      "mobile": "01737761787",
    },
    {
      "id": 23,
      "name": "Md. Nakibullah",
      "designation": "Territory Manager",
      "mobile": "01845968797",
    },
    {
      "id": 24,
      "name": "Abu Hanif",
      "designation": "Territory Manager",
      "mobile": "01744530966",
    },
    {
      "id": 25,
      "name": "Kazi AlAmin",
      "designation": "Junior Territory Manager",
      "mobile": "01765109241",
    },
    {
      "id": 26,
      "name": "Md Asaduzzaman",
      "designation": "Junior Territory Manager",
      "mobile": "01680054799",
    },
    {
      "id": 27,
      "name": "Bijoy Kumar",
      "designation": "Junior Territory Manager",
      "mobile": "01766221378",
    },
    {
      "id": 28,
      "name": "S M Mahfuzul Haq",
      "designation": "Junior Territory Manager",
      "mobile": "01756684805",
    },
    {
      "id": 29,
      "name": "Md. Rakibul Hasan",
      "designation": "Junior Territory Manager",
      "mobile": "01982013913",
    },
    {
      "id": 30,
      "name": "Md. Najmul",
      "designation": "Junior Territory Manager",
      "mobile": "01746316013",
    },
    {
      "id": 31,
      "name": "Md. Kazem Ali",
      "designation": "Junior Territory Manager",
      "mobile": "01739544599",
    },
    {
      "id": 32,
      "name": "Md. Shoriful Islam",
      "designation": "Junior Territory Manager",
      "mobile": "01710178918",
    },
    {
      "id": 33,
      "name": "Muhammad Ashikuzzaman Ashik",
      "designation": "Junior Territory Manager",
      "mobile": "01910480101",
    },
    {
      "id": 34,
      "name": "Md. Ripul Hossain",
      "designation": "Junior Territory Manager",
      "mobile": "01927122364",
    },
    {
      "id": 35,
      "name": "Minhaz Parvez",
      "designation": "Junior Territory Manager",
      "mobile": "01727831584",
    },

    // Page 3 (SL 36 to 74)
    {
      "id": 36,
      "name": "Piash Uddin",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01761936176",
    },
    {
      "id": 37,
      "name": "Md. Asharafujjaman",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01761081915",
    },
    {
      "id": 38,
      "name": "Md. Abdur Rahman",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01862693693",
    },
    {
      "id": 39,
      "name": "Md. Tofazzal Hossen",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01782459481",
    },
    {
      "id": 40,
      "name": "Md. Shamim Hossen",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01624001440",
    },
    {
      "id": 41,
      "name": "Gopal Chandro Roy",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01813115869",
    },
    {
      "id": 42,
      "name": "Md. Rohidul Islam Khan",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01783050510",
    },
    {
      "id": 43,
      "name": "Md. Munjurul Haque",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01770982615",
    },
    {
      "id": 44,
      "name": "Mostafizur Rahman",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01737846304",
    },
    {
      "id": 45,
      "name": "Md. Mukter Hossen",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01768487257",
    },
    {
      "id": 46,
      "name": "Md. Rubel Sheikh",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01709958477",
    },
    {
      "id": 47,
      "name": "Ruman Hossain",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01752726053",
    },
    {
      "id": 48,
      "name": "Junaid Islam",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01797722099",
    },
    {
      "id": 49,
      "name": "Masud Miah",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01711007019",
    },
    {
      "id": 50,
      "name": "Md. Shoriful Islam",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01755129361",
    },
    {
      "id": 51,
      "name": "Nadimul Hasan",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01724863686",
    },
    {
      "id": 52,
      "name": "Md. Al Helal",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01719975762",
    },
    {
      "id": 53,
      "name": "Shourub Hossain",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01738383505",
    },
    {
      "id": 54,
      "name": "Md. Gias Al Mahmud",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01783661825",
    },
    {
      "id": 55,
      "name": "Pranto Debnath",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01902423520",
    },
    {
      "id": 56,
      "name": "Md. Razu Ahmmed",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01712961165",
    },
    {
      "id": 57,
      "name": "Md. Shariful Islam",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01744619774",
    },
    {
      "id": 58,
      "name": "Md. Murad Hossain",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01922718014",
    },
    {
      "id": 59,
      "name": "Md. Belal Miah",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01719896675",
    },
    {
      "id": 60,
      "name": "Md. Hazrat Ali",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01742800851",
    },
    {
      "id": 61,
      "name": "Md. Faruk Mia",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01780712212",
    },
    {
      "id": 62,
      "name": "Md. Fahim Hossain",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01760286898",
    },
    {
      "id": 63,
      "name": "Md. Rakibul Islam",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01728335354",
    },
    {
      "id": 64,
      "name": "Md. Ferdous Bosuna",
      "designation": "Senior Sales Promotion Officer",
      "mobile": "01728896431",
    },
    {
      "id": 65,
      "name": "Prodip Barua",
      "designation": "Sales Promotion Officer",
      "mobile": "01814726279",
    },
    {
      "id": 66,
      "name": "Sabbir Ahmed Shameem",
      "designation": "Sales Promotion Officer",
      "mobile": "01875493821",
    },
    {
      "id": 67,
      "name": "Md. Firoze Mahmud",
      "designation": "Sales Promotion Officer",
      "mobile": "01783424296",
    },
    {
      "id": 68,
      "name": "Md. Sabbir Hossain",
      "designation": "Sales Promotion Officer",
      "mobile": "01737841067",
    },
    {
      "id": 69,
      "name": "Saiful Islam",
      "designation": "Sales Promotion Officer",
      "mobile": "01763837066",
    },
    {
      "id": 70,
      "name": "Suphal Chakma",
      "designation": "Sales Promotion Officer",
      "mobile": "01688478813",
    },
    {
      "id": 71,
      "name": "Ahsanul Haque",
      "designation": "Sales Promotion Officer",
      "mobile": "01712171144",
    },
    {
      "id": 72,
      "name": "Md. Masud Rana",
      "designation": "Sales Promotion Officer",
      "mobile": "01796218285",
    },
    {
      "id": 73,
      "name": "Sayeed Uz Zaman",
      "designation": "Sales Promotion Officer",
      "mobile": "01521377712",
    },
    {
      "id": 74,
      "name": "Md. Ruhul Amin",
      "designation": "Sales Promotion Officer",
      "mobile": "01749-558488",
    },

    // Page 4 non-Dr employees (SL 76, 83, 87, 88, 89, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103)
    {
      "id": 76,
      "name": "Md. Jakir Hossain (Suzan)",
      "designation": "Technical Head Aqua",
      "mobile": "01718461974",
    },
    {
      "id": 83,
      "name": "Md. Rasheduzzaman Khan Dipu",
      "designation": "Senior Executive (Technical)",
      "mobile": "01722-767271",
    },
    {
      "id": 87,
      "name": "Md. Ziaur Rahman",
      "designation": "Sr. Manager (Accounts)",
      "mobile": "01760086076",
    },
    {
      "id": 88,
      "name": "Rakib Hasan",
      "designation": "Accounts Officer (Accounts & Distribution)",
      "mobile": "01775997797",
    },
    {
      "id": 89,
      "name": "Mohammad Abdul Latif Mollah",
      "designation": "Assistant Officer (Billing & Credit)",
      "mobile": "01334198820",
    },
    {
      "id": 91,
      "name": "Md. Abdul Mannan",
      "designation": "Assistant General Manager (Eng.)",
      "mobile": "01710-905620",
    },
    {
      "id": 92,
      "name": "Anton Roy Chowdhury",
      "designation": "Assistant General Manager",
      "mobile": "01709-275775",
    },
    {
      "id": 93,
      "name": "Md. Tazul Islam Taz",
      "designation": "Deputy Manager",
      "mobile": "01710-495302",
    },
    {
      "id": 94,
      "name": "Joy Mojumder",
      "designation": "Manager (Marketing)",
      "mobile": "01795-216425",
    },
    {
      "id": 95,
      "name": "Md. Sajib Ahamed",
      "designation": "Assistant Manager (Engineering)",
      "mobile": "0176-0855657",
    },
    {
      "id": 96,
      "name": "Mahbub",
      "designation": "Senior Distribution Officer",
      "mobile": "0171-9986932",
    },
    {
      "id": 97,
      "name": "Md. Minhazul Abedin Shohag",
      "designation": "Senior Distribution Officer",
      "mobile": "0172-7902375",
    },
    {
      "id": 98,
      "name": "Md. Hamidullah",
      "designation": "Billing & Credit officer",
      "mobile": "0171-5814701",
    },
    {
      "id": 99,
      "name": "Kazi Mosharof Hossain",
      "designation": "Accountant (Cash & Bank)",
      "mobile": "0195-6286744",
    },
    {
      "id": 100,
      "name": "Sree Liton Chandra Das",
      "designation": "Assistant Officer (Accounts)",
      "mobile": "01780-433018",
    },
    {
      "id": 101,
      "name": "Md. Jamil Hossain (Sadaf)",
      "designation": "Junior Billing & Credit officer",
      "mobile": "0174-5257149",
    },
    {
      "id": 102,
      "name": "Md. Mintu Mia",
      "designation": "Assistant Distribution Officer",
      "mobile": "0161-7828960",
    },
    {
      "id": 103,
      "name": "Md. Lipon Mia",
      "designation": "Asst. Officer (Engineering)",
      "mobile": "01746-058496",
    },
  ];

  final vetDoctorsList = [
    // Page 3 SL 75
    {
      "id": 1,
      "name": "Dr. Kamrul Hasan Nayem",
      "designation": "Senior Technical Service Executive",
      "mobile": "01701073032",
    },

    // Page 4 Vet Doctors
    {
      "id": 2,
      "name": "Dr. Md. Abu Sayed Al Kabir",
      "designation": "Manager (Technical)",
      "mobile": "01717087835",
    },
    {
      "id": 3,
      "name": "Dr. Asif Iqbal",
      "designation": "Technical Service Executive",
      "mobile": "01740291006",
    },
    {
      "id": 4,
      "name": "Dr. Nasir Ahmmed",
      "designation": "Assistant Manager (Technical)",
      "mobile": "01955413045",
    },
    {
      "id": 5,
      "name": "Dr. Sheikh Khalid Mahmud",
      "designation": "Assistant Manager (Technical)",
      "mobile": "01307295027",
    },
    {
      "id": 6,
      "name": "Dr. Jahirul Islam",
      "designation": "Deputy Technical Manager",
      "mobile": "01748-480066",
    },
    {
      "id": 7,
      "name": "Dr. Asharaf Ali",
      "designation": "Assistant Manager (Technical)",
      "mobile": "01739-389948",
    },
    {
      "id": 8,
      "name": "Dr. U M M Mahdiuzzaman",
      "designation": "Executive (Technical)",
      "mobile": "01781-410901",
    },
    {
      "id": 9,
      "name": "Dr. Md. Tariqul Islam",
      "designation": "Assistant Manager (Technical)",
      "mobile": "01890-567144",
    },
    {
      "id": 10,
      "name": "Dr. Wasikul Amin Bipu",
      "designation": "Product Executive",
      "mobile": "01613-716307",
    },
    {
      "id": 11,
      "name": "Dr. Md. Kamrul Hasan",
      "designation": "BDM",
      "mobile": "01710-544274",
    },
  ];

  db.execute('DELETE FROM sales_personnel;');
  final stmtSp = db.prepare('''
    INSERT INTO sales_personnel (id, name_en, name_bn, designation, mobile, is_active, created_at, updated_at)
    VALUES (?, ?, ?, ?, ?, 1, ?, ?)
  ''');

  for (final sp in salesPersonnelList) {
    stmtSp.execute([
      sp['id'],
      sp['name'],
      sp['name'],
      sp['designation'],
      sp['mobile'],
      now,
      now,
    ]);
  }
  stmtSp.close();

  db.execute('DELETE FROM vet_doctors;');
  final stmtVet = db.prepare('''
    INSERT INTO vet_doctors (id, name_en, name_bn, qualification, specialization, mobile, is_active, created_at, updated_at)
    VALUES (?, ?, ?, ?, ?, ?, 1, ?, ?)
  ''');

  for (final vet in vetDoctorsList) {
    stmtVet.execute([
      vet['id'],
      vet['name'],
      vet['name'],
      vet['designation'],
      'Veterinary Medicine',
      vet['mobile'],
      now,
      now,
    ]);
  }
  stmtVet.close();

  db.close();
}
