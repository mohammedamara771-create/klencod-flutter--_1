import 'package:flutter/material.dart';

void main() {
  runApp(const RafiqSchoolApp());
}

class RafiqSchoolApp extends StatelessWidget {
  const RafiqSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رفيق المدرسة',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3157D5),
        ),
        fontFamily: 'Roboto',
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 35),

                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3157D5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    size: 55,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'رفيق المدرسة',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172554),
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'معاً لمتابعة أفضل لمستقبل أبنائنا',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),

                const SizedBox(height: 55),

                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'كيف تريد الدخول؟',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                RoleCard(
                  title: 'الدخول كأستاذ',
                  subtitle: 'إدارة التلاميذ والعلامات والغيابات',
                  icon: Icons.person_outline_rounded,
                  color: const Color(0xFF3157D5),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TeacherScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                RoleCard(
                  title: 'الدخول كولي',
                  subtitle: 'متابعة نتائج وغيابات الأبناء',
                  icon: Icons.family_restroom_rounded,
                  color: const Color(0xFF0D9B78),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ParentScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 45),

                const Text(
                  'الإصدار 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 17),
          ],
        ),
      ),
    );
  }
}

// ===============================
// واجهة الأستاذ
// ===============================

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final List<Map<String, String>> students = [
    {'name': 'أحمد محمد', 'class': 'السنة الأولى'},
    {'name': 'سارة علي', 'class': 'السنة الثانية'},
    {'name': 'يوسف خالد', 'class': 'السنة الثالثة'},
  ];

  void addStudent() {
    final nameController = TextEditingController();
    final classController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة تلميذ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'اسم التلميذ',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextField(
              controller: classController,
              decoration: const InputDecoration(
                labelText: 'القسم',
                prefixIcon: Icon(Icons.class_),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                setState(() {
                  students.add({
                    'name': nameController.text.trim(),
                    'class': classController.text.trim().isEmpty
                        ? 'غير محدد'
                        : classController.text.trim(),
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'لوحة الأستاذ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addStudent,
        icon: const Icon(Icons.add),
        label: const Text('إضافة تلميذ'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFF3157D5),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً بك أستاذنا 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'تابع تلاميذك وأدر معلوماتهم بسهولة.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: StatisticCard(
                  title: 'التلاميذ',
                  value: '${students.length}',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatisticCard(
                  title: 'الأقسام',
                  value: '3',
                  icon: Icons.class_,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          const Text(
            'قائمة التلاميذ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...students.map((student) {
            return Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE7EDFF),
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF3157D5),
                  ),
                ),
                title: Text(
                  student['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(student['class']!),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentDetailsScreen(
                        name: student['name']!,
                        studentClass: student['class']!,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ===============================
// بطاقة الإحصائيات
// ===============================

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

// ===============================
// ملف التلميذ
// ===============================

class StudentDetailsScreen extends StatelessWidget {
  final String name;
  final String studentClass;

  const StudentDetailsScreen({
    super.key,
    required this.name,
    required this.studentClass,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text('ملف التلميذ'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFE7EDFF),
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Color(0xFF3157D5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(studentClass),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          const FeatureCard(
            icon: Icons.grade,
            title: 'العلامات والنتائج',
            subtitle: 'متابعة مستوى التلميذ',
          ),
          const FeatureCard(
            icon: Icons.event_busy,
            title: 'الحضور والغياب',
            subtitle: 'سجل الحضور والتأخر',
          ),
          const FeatureCard(
            icon: Icons.psychology,
            title: 'السلوك',
            subtitle: 'الملاحظات والتقييمات التربوية',
          ),
          const FeatureCard(
            icon: Icons.menu_book,
            title: 'الواجبات والدروس',
            subtitle: 'الأنشطة والواجبات المدرسية',
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFE7EDFF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                Text(
                  'رمز ربط ولي التلميذ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'RFS-2026',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    color: Color(0xFF3157D5),
                  ),
                ),
                Text(
                  'رمز تجريبي للواجهة فقط',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================
// بطاقات الخدمات
// ===============================

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF3157D5), size: 28),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
    );
  }
}

// ===============================
// واجهة ولي التلميذ
// ===============================

class ParentScreen extends StatelessWidget {
  const ParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final codeController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text('لوحة ولي التلميذ'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const Icon(
                Icons.family_restroom,
                size: 75,
                color: Color(0xFF0D9B78),
              ),
              const SizedBox(height: 20),
              const Text(
                'ربط حسابك بالتلميذ',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'أدخل رمز الربط الذي استلمته من الأستاذ.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: codeController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'أدخل رمز الربط',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF0D9B78),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'سيتم تفعيل ربط الحساب عند إضافة قاعدة البيانات.',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'ربط الحساب',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}