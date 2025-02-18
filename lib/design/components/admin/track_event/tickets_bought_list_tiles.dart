import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class TicketsBoughtListTiles extends StatefulWidget {
  const TicketsBoughtListTiles({
    super.key,
    this.limitCount,
  });

  final int? limitCount;

  @override
  State<TicketsBoughtListTiles> createState() => _TicketsBoughtListTilesState();
}

class _TicketsBoughtListTilesState extends State<TicketsBoughtListTiles> {
  final List<Map<String, String>> ticketsBought = [
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
    {
      'name1': 'Aashima',
      'name2': 'Abhishek',
      'imageUrl1':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'imageUrl2':
          'https://s3-alpha-sig.figma.com/img/97eb/4576/f36dff298370a405985626df3e035acd?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=rFIfXC~b2ZB2ah-KlHr2TPs2OKSkuZKLZdRNDwfVBnkM5OpMa3C7dOi~GpRj7RC9WMKlR0gt1kDzFiLKmnPihmIX0u-R2J2InRE7v8Ad1BrGxra6TOU1KGswmw1SSJ9KuBrx8BAvK-Wvx4kBFVPUGSjlm6btI~Ltz9GAvDToKMt85g5~~fni8AneGgUs-Q~YT~DJN2HpBmEKvgtmBmmN9-QdBOcC6lZ2ZGulbGD9mgIn15bkIbYqc3TLK9H5gMe7T~hT5~H1gGqaqfMXi7zxxmMLii7gkfRRXGNZrqF7c~EvhMLMGyMQNurEwjWt-Odn150SJNgijlnxwG8SKMzZWw__',
      'date': '2023-01-01',
      'time': '12:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: widget.limitCount == null
          ? null
          : const NeverScrollableScrollPhysics(),
      itemCount: widget.limitCount ?? ticketsBought.length,
      itemBuilder: (context, index) {
        print(index);
        final person = ticketsBought[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _buildProfileRow(
            profileImageUrl1: person['imageUrl1']!,
            profileImageUrl2: person['imageUrl2']!,
            name1: person['name1']!,
            name2: person['name2']!,
            date: person['date']!,
            time: person['time']!,
          ),
        );
      },
    );
  }

  Widget _buildProfileRow({
    required String profileImageUrl1,
    required String profileImageUrl2,
    required String name1,
    required String name2,
    required String date,
    required String time,
  }) {
    final profileImageUrl = [profileImageUrl1, profileImageUrl2];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColours.borderGray,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            // profile picture
            ...profileImageUrl.map(
              (userImage) => Align(
                widthFactor: 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundImage: NetworkImage(userImage),
                  ),
                ),
              ),
            ),

            const Gap(24.0),

            //profile name
            Text(
              '$name1 & $name2',
              style: AppTheme.simpleText,
            ),
            const Spacer(),
            // date and time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: AppTheme.smallBodyText.copyWith(fontSize: 10.0),
                ),
                const Gap(2.0),
                Text(
                  time,
                  style: AppTheme.smallBodyText.copyWith(fontSize: 10.0),
                ),
              ],
            ),

            // spacing in content and scrolls bar
            if (widget.limitCount == null) const Gap(24.0),
          ],
        ),
      ),
    );
  }
}
