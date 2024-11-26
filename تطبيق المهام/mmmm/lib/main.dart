import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قائمة المهام الخاصة',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
  
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  final String correctPassword = '123456'; // الكلمة السرية المدخلة

  void login() {
    if (passwordController.text == correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('كلمة السر خاطئة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100, // Lighter shade of blue
              Colors.blue.shade300, // Slightly darker shade
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
  top: 140.0,
  bottom: 100.0,
  left: 30.0,
  right: 30.0,
),

            child: Card(
              elevation: 8, // Increased elevation
              shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20), // Increased border radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0), // Increased padding

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                   [
                   Icon(Icons.lock,size: 100.0,color: Colors.blue,),
               
                    SizedBox(height: 20),
                        
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                    ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                      obscureText: true,
                        
                      
                    ),
                    SizedBox(height: 20),
               
                        
                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55), // Increased button height
                        backgroundColor: Colors.blue.shade600, // Darker blue button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30), // Increased padding
                      ),
                      child: const Text('Login', style: TextStyle(fontSize: 18,color: Colors.white),), // Larger text
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Task {
  String title;
  String description;
  String date;
  String category;
  String priority;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.priority,
  });
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [];
  int selectedIndex = 0;

  void addTask(String category) {
    // دالة لإضافة مهمة جديدة
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        String date = '';
        String priority = 'عادي';

        return AlertDialog(
          title: Text(' مهام   - $category'),
          icon: Icon(Icons.task,color: Colors.blue,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
           
              TextFormField(
                onChanged: (value) => title = value,
                decoration: InputDecoration(
                  labelText: 'اسم المهمة',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                  filled: true, // Filled background
                  fillColor: Colors.grey.shade200, // Light grey fill
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(
                  labelText: 'وصف المهمة',
                  prefixIcon: const Icon(Icons.task_sharp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                  filled: true, // Filled background
                  fillColor: Colors.grey.shade200, // Light grey fill
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => date = value,
                // DateTime(date.year, date.month, date.day),//////////////////////////////
                decoration: InputDecoration(
                  labelText: 'تاريخ المهمة',
                  prefixIcon: const Icon(Icons.data_object_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                  filled: true, // Filled background
                  fillColor: Colors.grey.shade200, // Light grey fill
                ),
              ),


              DropdownButton<String>(
                
                value: priority,
                items: <String>['عادي', 'مهم', 'عاجل']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    priority = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // لون الخلفية
              ),
              onPressed: () {
                setState(() {
                  tasks.add(Task(
                    title: title,
                    description: description,
                    date: date,
                    category: category,
                    priority: priority,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: Text('إضافة',style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // لون الخلفية
              ),
              
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إلغاء',style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  List<Task> getFilteredTasks() {
    switch (selectedIndex) {
      case 0:
        return tasks.where((task) => task.category == 'الدراسة').toList();
      case 1:
        return tasks.where((task) => task.category == 'العمل').toList();
      case 2:
        return tasks.where((task) => task.category == 'المنزل').toList();
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('List Fo work', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade800, Colors.blue.shade500],
          ),
        ),
      ),
      
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {   (context);
},
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        ),
      ],
    ),
    
     drawer: Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
          accountName: Text("Mohammed Kaled BASAA"),
          accountEmail: Text("basaa@gimal.com"),
          currentAccountPicture: CircleAvatar(
            child:ClipOval(
              child: Image.network("data:image/jpeg;base64,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",
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              ),

            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: NetworkImage("data:image/jpeg;base64,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",

              ),
              fit: BoxFit.cover
              )
          ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("favorite"),
            onTap: () => null,
          ),
            ListTile(
            leading: Icon(Icons.people),
            title: Text("Friends"),
            onTap: () => null,
          ),
            ListTile(
            leading: Icon(Icons.share),
            title: Text("share"),
            onTap: () => null,
          ),
            ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Request"),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("settings"),
            onTap: () => null,
          ),
            ListTile(
            leading: Icon(Icons.description),
            title: Text("Policies"),
            onTap: () => null,
          ),
          Divider(),
            ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Exit"),
            onTap: () => null,
          ),
      
        ],
      ),
    ),
      body: ListView.builder(
        itemCount: getFilteredTasks().length,
        itemBuilder: (context, index) {
          final task = getFilteredTasks()[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text('${task.description}\nتاريخ: ${task.date} - أولوية: ${task.priority}'),
              leading: Icon(
                task.category == 'الدراسة'
                    ? Icons.school
                    : task.category == 'العمل'
                        ? Icons.work
                        : Icons.home,
              ),
            ),
          );
        },
      ),
   
      
      bottomNavigationBar: BottomNavigationBar(
      
       
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade800,
      unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },


        items:const [
          
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: 'مهام دراسية'),
          BottomNavigationBarItem(
              icon: Icon(Icons.work), label: 'مهام عمل'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'مهام منزلية'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (selectedIndex) {
            case 0:
              addTask('الدراسة');
              break;
            case 1:
              addTask('العمل');
              break;
            case 2:
              addTask('المنزل');
              break;
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}