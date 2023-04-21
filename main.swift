//
//  main.swift
//  MyCreditManager
//
//  Created by 여성일 on 2023/04/21.
//

import Foundation

struct Student {
    var name: String // 학생 이름
    var gradeArr: [String:String] = [:] // 과목(grade), 성적(score) dictionary
    
    func calcRating() {
        gradeArr.forEach {
            print("\($0.key): \($0.value)")
        }
        
        let avgRating = gradeArr.compactMap {
            gradeRating[$0.value]
        }.reduce(0, +) / Float(gradeArr.count)
        
        let numberFomatter = NumberFormatter()
        numberFomatter.roundingMode = .floor
        numberFomatter.maximumSignificantDigits = 3
        let avgStrRating = numberFomatter.string(for: avgRating) ?? ""
        
        print("평점 : \(avgStrRating)")
    }
}

var stuArr: [Student] = [] // 학생 배열

let gradeRating: [String: Float] = ["A+":4.5, "A":4.0, "B+":3.5, "B":3.0, "C+":2.5, "C":2.0,
                                    "D+":1.5, "D":1.0, "F":0]
// 학생 추가 함수
func addStu() {
    print("추가할 학생의 이름을 입력해주세요")
    let input = readLine()! // readLine()은 리턴 값이 옵셔널이므로 언래핑, 값이 확실하므로 !로 강제언래핑함
    if input != "" && input != " " {
        if stuArr.contains(where: { $0.name == input }) { // 클로저로 축약
            print("\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            stuArr.append(.init(name: input))
            print("\(input) 학생을 추가했습니다.")
        }
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
}

// 학생 삭제 함수
func delStu() {
    print("삭제할 학생의 이름을 입력해주세요")
    let input = readLine()!
    if let stuIndex = stuArr.firstIndex(where: {$0.name == input}) {
        stuArr.remove(at: stuIndex)
        print("\(input) 학생을 삭제하였습니다.")
    } else {
        print("\(input) 학생을 찾지 못했습니다.")
    }
}

func addGrade() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    if let inputArr = readLine()?.split(separator: " "),
       inputArr.count == 3,
       let stuName = inputArr.first,
       let stuScore = inputArr.last,
       let stuIndex = stuArr.firstIndex(where: { $0.name == stuName }),
       gradeRating.contains(where: { $0.key == stuScore }) {
        let stuGrade = String(inputArr[1])
        stuArr[stuIndex].gradeArr[stuGrade] = String(stuScore)
        print("\(stuName) 학생의 \(stuGrade) 과목이 \(stuScore)로 추가(변경)되었습니다.")
    } else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
}

func delGrade() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    
    if let inputArr = readLine()?.split(separator: " "),
       inputArr.count == 2,
       let stuName = inputArr.first,
       let stuGrade = inputArr.last {
        if let stuIndex = stuArr.firstIndex(where: { $0.name == stuName }) {
            stuArr[stuIndex].gradeArr.removeValue(forKey: String(stuGrade))
            print("\(stuName) 학생의 \(stuGrade) 과목의 성적이 삭제되었습니다.")
        } else {
            print("\(stuName) 학생을 찾지 못했습니다.")
        }
    }
}

func viewRating() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    
    let input = readLine()!
    
    if let stuIndex = stuArr.first(where: { $0.name == input }) {
        stuIndex.calcRating()
    } else {
        print("\(input) 학생을 찾지 못했습니다.")
    }
}

while true {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    
    let input = readLine()!
    
    if input == "1" {
        addStu()
    }
    else if input == "2" {
        delStu()
    }
    else if input == "3" {
        addGrade()
    }
    else if input == "4" {
        delGrade()
    }
    else if input == "5" {
        viewRating()
    }
    else if input == "X" {
        print("프로그램을 종료합니다...")
        break
    }
    else {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
}

