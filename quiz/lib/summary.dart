import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResSummary extends StatelessWidget{
  const ResSummary(this.data, this.correctData,{super.key});

  final List<Map<String,Object>> data;
  final List<bool> correctData;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: SingleChildScrollView(
        child: Column(
          children:
          data.map((d) {
            return Container(
              decoration: const BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: Colors.black))),
              child: Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: (correctData[(d['question_index']as int) - 1])?const Color.fromARGB(255, 2, 238, 10): Colors.red,
                          child: Text(d['question_index'].toString(),
                          style: const TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      const SizedBox(height: 100,),
                    ],
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Text(d['question']as String,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kalam(
                            color: Color.fromARGB(255, 255, 230, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                        ),),
                        Text('Your Answer:     ${d['user_answer'] as String}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kalam(
                            color: (correctData[(d['question_index']as int) - 1])?const Color.fromARGB(255, 2, 238, 10): Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                        ),),
                        Text('Correct Answer: ${d['correct_answer'] as String}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.kalam(
                            color: const Color.fromARGB(255, 2, 238, 10),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          
        ),
      ),
    );
  }


}