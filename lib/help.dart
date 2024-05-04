import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  // Define some sample FAQ data
  final List<Map<String, String>> faqs = [
    {
      'question': 'Am I eligible to donate blood?',
      'answer':
      'To donate blood, you must generally be in good health, meet age and weight requirements, and not have certain health conditions or recent travel history. See a donation center\'s guidelines for specific eligibility criteria.'
    },
    {
      'question': 'How often can I donate blood?',
      'answer':
      'The frequency of blood donation depends on the type of donation (whole blood, platelets, etc.). Typically, donors can donate whole blood every 8 weeks, platelets every 7 days, double red cells every 112 days, and plasma every 28 days.'
    },
    // Add more FAQs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation Help & Support'),
      ),
      body: ListView(
        children: [
          Card(
            child: ExpansionTile(
              title: Text('FAQs'),
              children: faqs.map((faq) {
                return ListTile(
                  title: Text(faq['question']!),
                  subtitle: Text(faq['answer']!),
                );
              }).toList(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('How to Prepare for Donation'),
              subtitle: Text(
                  'Learn about the steps you can take to prepare for a blood donation, including staying hydrated, getting enough rest, and eating iron-rich foods.'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Benefits of Blood Donation'),
              subtitle: Text(
                  'Discover the benefits of donating blood, such as helping those in need, stabilizing the blood supply, and potentially reducing the risk of certain health conditions.'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Common Concerns'),
              subtitle: Text(
                  'Find answers to common concerns about blood donation, including fear of needles, possible side effects, and eligibility criteria.'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Eligibility Details'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Check if you meet the eligibility criteria for blood donation based on factors such as age, weight, height, health condition, and recent travel history.'),
                  SizedBox(height: 8),
                  Text('Eligibility Requirements:'),
                  Text('- Age: 17 years or older (or 16 with parental consent)'),
                  Text('- Weight: At least 110 pounds'),
                  Text('- Height: Must meet minimum height requirements'),
                  Text('- Health Condition: Must be in good health and feeling well'),
                  Text('- Recent Travel: Review travel history to ensure eligibility'),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Tattoo Related'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'If you have recently gotten a tattoo, you may need to wait for a certain period before being eligible to donate blood. Learn more about the guidelines regarding tattoos and blood donation.'),
                  SizedBox(height: 8),
                  Text('Tattoo Guidelines:'),
                  Text('- Wait period: Typically 3-12 months after getting a tattoo'),
                  Text('- Location: Ensure the tattoo was performed in a licensed facility'),
                  Text('- Cleanliness: Ensure the tattoo and surrounding area are clean and free of infection'),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Replace this with functionality to contact support
          // For example, opening an email composer
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Contact Support'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('For assistance, contact us at:'),
                  SizedBox(height: 10),
                  Text('Email: support@blooddonation.org'),
                  Text('Phone: 1-800-555-1234'),
                  SizedBox(height: 20),
                  Text('Admin Contact:'),
                  Text('Email: admin@blooddonation.org'),
                  Text('Phone: 1-800-123-4567'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.email),
      ),
    );
  }
}
