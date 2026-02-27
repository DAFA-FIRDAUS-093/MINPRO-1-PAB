import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ParkirPage(),
    );
  }
}

class ParkirPage extends StatefulWidget {
  const ParkirPage({super.key});

  @override
  State<ParkirPage> createState() => _ParkirPageState();
}

class _ParkirPageState extends State<ParkirPage> {

  final TextEditingController platController = TextEditingController();
  final TextEditingController jenisController = TextEditingController();
  final TextEditingController jamController = TextEditingController();

  List<Map<String, String>> dataParkir = [];

  // CREATE
  void tambahData() {
    if (platController.text.isEmpty ||
        jenisController.text.isEmpty ||
        jamController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field harus diisi!")),
      );
      return;
    }

    setState(() {
      dataParkir.add({
        "plat": platController.text,
        "jenis": jenisController.text,
        "jam": jamController.text,
      });

      platController.clear();
      jenisController.clear();
      jamController.clear();
    });
  }

  // DELETE
  void hapusData(int index) {
    setState(() {
      dataParkir.removeAt(index);
    });
  }

  // UPDATE
  void editData(int index) {
    TextEditingController platEdit =
        TextEditingController(text: dataParkir[index]["plat"]);
    TextEditingController jenisEdit =
        TextEditingController(text: dataParkir[index]["jenis"]);
    TextEditingController jamEdit =
        TextEditingController(text: dataParkir[index]["jam"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: platEdit,
                decoration: const InputDecoration(labelText: "Plat Nomor"),
              ),
              TextField(
                controller: jenisEdit,
                decoration: const InputDecoration(labelText: "Jenis Kendaraan"),
              ),
              TextField(
                controller: jamEdit,
                decoration: const InputDecoration(labelText: "Jam Masuk"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  dataParkir[index] = {
                    "plat": platEdit.text,
                    "jenis": jenisEdit.text,
                    "jam": jamEdit.text,
                  };
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Data Parkir"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: platController,
              decoration: const InputDecoration(
                labelText: "Plat Nomor",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: jenisController,
              decoration: const InputDecoration(
                labelText: "Jenis Kendaraan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: jamController,
              decoration: const InputDecoration(
                labelText: "Jam Masuk",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: tambahData,
              child: const Text("Tambah Data"),
            ),

            const SizedBox(height: 20),

            const Text(
              "Data Kendaraan Masuk:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: dataParkir.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(dataParkir[index]["plat"]!),
                      subtitle: Text(
                          "Jenis: ${dataParkir[index]["jenis"]} | Jam: ${dataParkir[index]["jam"]}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => editData(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => hapusData(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}